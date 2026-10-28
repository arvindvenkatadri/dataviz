#!/usr/bin/env Rscript
# consolidate_themes.R -- stop copy-pasting the ggplot theme into every lesson.
#
# Base R only (needs R >= 4.0 for raw strings; no packages to install).
#
# What it does
# ------------
# 1. Finds every R chunk in the project's .qmd files that defines `theme_custom`.
# 2. Fingerprints the function (ignoring comments, whitespace and `ggplot2::`).
#    Pages that share a design share one fingerprint.
# 3. Writes ONE shared file, R/theme-hatter.R, containing:
#      - font registration (local files in fonts/, Google Fonts fallback)
#      - one theme function per design found on 2+ pages, copied verbatim
#      - the geom / table defaults that used to be pasted into each page
# 4. Replaces each recognised page chunk with a short stub:
#
#        source(here::here("R", "theme-hatter.R"))
#        theme_custom <- theme_hatter_exhibit
#        ggplot2::theme_set(new = theme_custom())
#
#    `theme_custom` keeps working at every existing call site, so the rest of
#    each page is untouched and figures should render identically.
#
# Pages whose theme is a one-off, or whose chunk contains code this script does
# not recognise, are LEFT ALONE and listed for manual review. Nothing is guessed.
#
# Usage
# -----
# From a terminal, anywhere inside the repo:
#
#     Rscript scripts/consolidate_themes.R              # dry run: report only
#     Rscript scripts/consolidate_themes.R --diff 3     # ...and show 3 diffs
#     Rscript scripts/consolidate_themes.R --report     # list design fingerprints
#     Rscript scripts/consolidate_themes.R --apply      # write changes
#
# From RStudio / an R session:
#
#     source("scripts/consolidate_themes.R")
#     consolidate_themes()                     # dry run
#     consolidate_themes(show_diff = 3)
#     consolidate_themes(apply = TRUE)
#
# Other options: --root PATH, --force (skip the clean-git-tree check),
# --min-pages N (designs used on fewer pages stay local; default 2).
#
# The generated R code is always parse-checked before anything is written.
# Idempotent: after --apply, a second run finds nothing left to convert.
# Use git to review / revert.

# ---- Configuration ----------------------------------------------------------
SKIP_DIRS <- c("_site", "_freeze", ".git", ".ipynb_checkpoints", "_extensions",
               "node_modules", "renv", "R")
SHARED_R  <- file.path("R", "theme-hatter.R")
FONTS     <- c("Alegreya", "Roboto Condensed")

# fingerprint -> shared function name + description.
# Add new designs from the output of:  Rscript scripts/consolidate_themes.R --report
KNOWN_DESIGNS <- list(
  "3cec8e58" = list(name = "theme_hatter_exhibit",
                    desc = "theme_bw, bisque frame, 10/8/6 pt text (the 'exhibit' look)"),
  "a2eac89b" = list(name = "theme_hatter_compact",
                    desc = "theme_bw, no frame, smaller 8/6 pt axis text"),
  "ed42c857" = list(name = "theme_hatter_alegreya",
                    desc = "theme_classic in Alegreya, 24 pt title (case studies)"),
  "175f2396" = list(name = "theme_hatter_roboto",
                    desc = "theme_classic in Roboto Condensed, 20 pt title")
)

# ---- Small R-aware text utilities -------------------------------------------
# Work on bytes so strings, comments and UTF-8 text are all handled safely.
DQ <- 34L; SQ <- 39L; BT <- 96L; BS <- 92L; HASH <- 35L; NL <- 10L
LP <- 40L; RP <- 41L; LB <- 91L; RB <- 93L; LC <- 123L; RC <- 125L
WS   <- c(32L, 9L, 10L, 11L, 12L, 13L)
CONT <- utf8ToInt("+-*/^,=<>|&!~%(\\")     # trailing char => statement continues

utf8 <- function(x) { Encoding(x) <- "UTF-8"; x }
bytes_to_str <- function(b) if (length(b)) utf8(rawToChar(as.raw(b))) else ""
is_blank <- function(s) grepl("^[[:space:]]*$", s)

strip_comments <- function(code) {
  b <- as.integer(charToRaw(code)); n <- length(b)
  keep <- rep(TRUE, n); quote <- 0L; i <- 1L
  while (i <= n) {
    c <- b[i]
    if (quote != 0L) {
      if (c == BS && i < n) { i <- i + 2L; next }
      if (c == quote) quote <- 0L
    } else if (c == DQ || c == SQ || c == BT) {
      quote <- c
    } else if (c == HASH) {
      while (i <= n && b[i] != NL) { keep[i] <- FALSE; i <- i + 1L }
      next
    }
    i <- i + 1L
  }
  bytes_to_str(b[keep])
}

# -> list of list(kind = "comment"|"stmt", text = ...). Handles strings,
# brackets, and statements continued by a trailing operator.
split_statements <- function(code) {
  b <- as.integer(charToRaw(code)); n <- length(b)
  out <- list(); cur_start <- 1L; depth <- 0L; quote <- 0L
  last_sig <- 0L; standalone <- FALSE; i <- 1L

  slice <- function(a, z) if (z >= a) bytes_to_str(b[a:z]) else ""
  emit  <- function(z) {
    txt <- gsub("^\n+|\n+$", "", slice(cur_start, z))
    out[[length(out) + 1L]] <<- list(kind = "stmt", text = txt)
    cur_start <<- z + 1L; last_sig <<- 0L
  }

  while (i <= n) {
    c <- b[i]
    if (quote != 0L) {
      if (c == BS && i < n) { i <- i + 2L; next }
      if (c == quote) { quote <- 0L; last_sig <- c }
      i <- i + 1L; next
    }
    if (c == DQ || c == SQ || c == BT) { quote <- c; i <- i + 1L; next }
    if (c == HASH) {
      j <- i
      while (j <= n && b[j] != NL) j <- j + 1L      # j = newline index (or n + 1)
      if (is_blank(slice(cur_start, i - 1L))) {      # comment on a line of its own
        out[[length(out) + 1L]] <- list(kind = "comment", text = slice(i, j - 1L))
        standalone <- TRUE
      }
      i <- j; next
    }
    if (c == LP || c == LB || c == LC) depth <- depth + 1L
    else if (c == RP || c == RB || c == RC) depth <- depth - 1L
    if (c == NL) {
      if (standalone || is_blank(slice(cur_start, i))) {
        cur_start <- i + 1L; standalone <- FALSE
      } else if (depth <= 0L && !(last_sig %in% CONT)) {
        emit(i)
      }
      i <- i + 1L; next
    }
    if (!(c %in% WS)) last_sig <- c
    i <- i + 1L
  }
  if (!standalone && !is_blank(slice(cur_start, n))) emit(n)
  out
}

norm <- function(stmt) trimws(gsub("\\s+", " ", strip_comments(stmt)))

md5_8 <- function(s) {
  f <- tempfile(); on.exit(unlink(f))
  writeBin(charToRaw(s), f)
  substr(unname(tools::md5sum(f)), 1, 8)
}

fingerprint <- function(fn_text) {
  t <- strip_comments(fn_text)
  t <- gsub("ggplot2::", "", t, fixed = TRUE)
  t <- gsub("'", "\"", t, fixed = TRUE)
  md5_8(gsub("\\s+", "", t))
}

# ---- Classifying the statements that sit next to the theme definition -------
classify <- function(stmt) {
  s <- norm(stmt)
  if (startsWith(s, "theme_custom <- function")) return("theme-def")
  if (grepl("^library\\((systemfonts|showtext|sysfonts)\\)$", s)) return("boilerplate")
  if (grepl("^(systemfonts::)?clear_(local_fonts|registry)\\(\\)$", s)) return("boilerplate")
  if (grepl("^(showtext::)?showtext_(opts|auto)\\(", s)) return("boilerplate")
  if (grepl("^(sysfonts::)?font_add(_google)?\\(", s)) {
    fam <- regmatches(s, regexpr("\"[^\"]+\"", s))
    fam <- if (length(fam)) gsub("\"", "", fam, fixed = TRUE) else NA_character_
    return(if (!is.na(fam) && fam %in% FONTS) "boilerplate" else "residual")
  }
  if (grepl("^(ggplot2::)?update_geom_defaults\\(", s)) {
    m <- regmatches(s, regexec("geom\\s*=\\s*\"(\\w+)\"|\\(\\s*\"(\\w+)\"", s,
                               perl = TRUE))[[1]]
    g <- if (length(m) >= 2L) { if (nzchar(m[2])) m[2] else if (length(m) >= 3L) m[3] else "" } else ""
    known <- c("text", "label", "marquee", "text_repel", "label_repel")
    ok <- grepl("Roboto Condensed", s, fixed = TRUE) && grepl("3.5", s, fixed = TRUE) &&
      grepl("#2b2b2b", s, fixed = TRUE)
    return(if (g %in% known && ok) "boilerplate" else "residual")
  }
  if (grepl(paste0("^options\\(\\s*\"?tinytable_(tt_digits|format_num_fmt|html_mathjax)\"?",
                   "\\s*=\\s*(2|\"significant_cell\"|TRUE)\\s*\\)$"), s))
    return("boilerplate")
  if (s == "flextable::set_flextable_defaults(font.family = \"Roboto Condensed\")")
    return("boilerplate")
  if (grepl("^(ggplot2::)?theme_set\\(", s) && grepl("theme_custom()", s, fixed = TRUE))
    return("theme-set")
  "residual"
}

# ---- Chunk handling ---------------------------------------------------------
split_lines <- function(text) strsplit(paste0(text, "\n"), "\n", fixed = TRUE)[[1]]

find_chunks <- function(lines) {
  opens  <- grep("^```\\{r\\b.*\\}[ \t]*$", lines, perl = TRUE)
  closes <- grep("^```[ \t]*$", lines, perl = TRUE)
  chunks <- list(); last_close <- 0L
  for (o in opens) {
    if (o <= last_close) next
    cl <- closes[closes > o]
    if (!length(cl)) break
    chunks[[length(chunks) + 1L]] <- list(open = o, close = cl[1])
    last_close <- cl[1]
  }
  chunks
}

analyse_chunk <- function(body) {          # body: character vector of chunk lines
  k <- 0L
  while (k < length(body) && startsWith(trimws(body[k + 1L], "left"), "#|")) k <- k + 1L
  header <- body[seq_len(k)]
  rest   <- body[-seq_len(k)]
  code   <- if (length(rest)) paste0(paste(rest, collapse = "\n"), "\n") else ""
  info <- list(header = header, fn = NULL, theme_set = NULL, residual = character())
  pending <- character()
  for (it in split_statements(code)) {
    if (it$kind == "comment") { pending <- c(pending, it$text); next }
    cls <- classify(it$text)
    if (cls == "theme-def") info$fn <- it$text
    else if (cls == "theme-set") info$theme_set <- norm(it$text)
    else if (cls == "residual")
      info$residual <- c(info$residual, paste(c(pending, it$text), collapse = "\n"))
    pending <- character()
  }
  info
}

make_stub <- function(design_name, info) {
  # Statements the page already had in this chunk (library(ggrepel), etc.) go
  # FIRST: the shared file applies geom defaults to ggrepel/marquee, which only
  # works once those packages are attached.
  lines <- c(
    info$residual,
    "source(here::here(\"R\", \"theme-hatter.R\"))  # fonts, geom/table defaults, themes",
    sprintf("theme_custom <- %s  # same design this page used to define locally", design_name)
  )
  if (!is.null(info$theme_set)) lines <- c(lines, info$theme_set)
  unlist(strsplit(paste(lines, collapse = "\n"), "\n", fixed = TRUE))
}

# ---- Shared R file ----------------------------------------------------------
R_HEAD <- r"-----(# R/theme-hatter.R ------------------------------------------------------------
# Shared look for "The Mad Hatter's Guide to Data Viz and Stats in R".
# Generated by scripts/consolidate_themes.R; edit freely afterwards.
#
# Pages use it like this (one source() line instead of ~60 lines):
#   source(here::here("R", "theme-hatter.R"))
#   theme_custom <- theme_hatter_exhibit
#   ggplot2::theme_set(new = theme_custom())
# -----------------------------------------------------------------------------
suppressPackageStartupMessages({
  library(ggplot2)
  library(here)
})

# ---- Fonts ------------------------------------------------------------------
# Local files in <project>/fonts first (works offline), Google Fonts fallback.
# Registered once per R session. ragg/ggrepel read fonts from systemfonts,
# showtext reads from sysfonts, so both are told about each face.
if (!isTRUE(getOption("hatter.fonts_ready"))) {
  suppressPackageStartupMessages({
    library(systemfonts)
    library(sysfonts)
    library(showtext)
  })

  .font_file <- function(...) {
    path <- here::here("fonts", ...)
    if (file.exists(path)) path else NULL
  }

  .register_face <- function(family, regular, bold = NULL, italic = NULL,
                             bolditalic = NULL, google = family) {
    if (!is.null(regular) && file.exists(regular)) {
      sysfonts::font_add(family = family, regular = regular,
                         bold = bold, italic = italic, bolditalic = bolditalic)
      try(systemfonts::register_font(
        name = family, plain = regular,
        bold = if (is.null(bold)) regular else bold,
        italic = if (is.null(italic)) regular else italic,
        bolditalic = if (is.null(bolditalic)) regular else bolditalic
      ), silent = TRUE)
    } else {
      tryCatch(sysfonts::font_add_google(name = google, family = family),
               error = function(e) warning("Could not register font '", family,
                                           "': ", conditionMessage(e)))
    }
    invisible(family)
  }

  showtext::showtext_opts(dpi = 96)
  .register_face("Alegreya",
                 .font_file("Alegreya-Regular.ttf"),
                 .font_file("Alegreya-Bold.ttf"),
                 .font_file("Alegreya-Italic.ttf"),
                 .font_file("Alegreya-BoldItalic.ttf"))
  .register_face("Roboto Condensed",
                 .font_file("RobotoCondensed-Regular.ttf"),
                 .font_file("RobotoCondensed-Bold.ttf"),
                 .font_file("RobotoCondensed-Italic.ttf"),
                 .font_file("RobotoCondensed-BoldItalic.ttf"))
  showtext::showtext_auto(enable = TRUE)
  options(hatter.fonts_ready = TRUE)
}

# ---- Themes (each copied verbatim from the pages that used it) -------------
)-----"

R_TAIL <- paste0("\n", r"-----(# ---- Geom defaults (formerly pasted into every page) ------------------------
# NB: text geoms use `fontface`/`colour` (the old per-page copies said `face`/
# `color`); this matches what _setup.qmd already does.
.hatter_text_defaults <- list(family = "Roboto Condensed", fontface = "plain",
                              size = 3.5,                 # millimetres
                              colour = "#2b2b2b")
for (.g in c("text", "label", "marquee", "text_repel", "label_repel")) {
  tryCatch(ggplot2::update_geom_defaults(.g, .hatter_text_defaults),
           error = function(e) invisible(NULL))   # package not attached: skip
}
rm(.g)

# ---- Table defaults ---------------------------------------------------------
options(tinytable_tt_digits = 2,
        tinytable_format_num_fmt = "significant_cell",
        tinytable_html_mathjax = TRUE)
if (requireNamespace("flextable", quietly = TRUE)) {
  flextable::set_flextable_defaults(font.family = "Roboto Condensed")
}
)-----")

rename_fn <- function(fn_text, new_name)
  sub("^theme_custom\\s*<-", paste0(new_name, " <-"), trimws(fn_text))

build_r_file <- function(designs) {              # designs: named list(name, desc, fn, count)
  parts <- R_HEAD
  for (d in designs)
    parts <- c(parts, sprintf("# %s  (used by %d pages)\n%s\n",
                              d$desc, d$count, rename_fn(d$fn, d$name)))
  parts <- c(parts, R_TAIL)
  paste(parts, collapse = "\n")
}

# ---- Project scan -----------------------------------------------------------
find_root <- function(start) {
  p <- normalizePath(start, mustWork = TRUE)
  repeat {
    if (file.exists(file.path(p, "_quarto.yml"))) return(p)
    parent <- dirname(p)
    if (identical(parent, p)) stop("Could not find _quarto.yml; pass root = '/path/to/repo'")
    p <- parent
  }
}

qmd_files <- function() {                         # relative to the working dir
  f <- list.files(".", pattern = "\\.qmd$", recursive = TRUE, all.files = TRUE)
  f <- sub("^\\./", "", f)
  ok <- vapply(strsplit(f, "/", fixed = TRUE), function(p) {
    d <- p[-length(p)]
    !any(d %in% SKIP_DIRS | startsWith(d, "."))
  }, logical(1))
  f <- f[ok]
  # sort by path component, like a file browser: "/" sorts before everything
  f[order(gsub("/", "\001", f, fixed = TRUE), method = "radix")]
}

read_qmd <- function(path) {
  txt  <- utf8(rawToChar(readBin(path, "raw", file.info(path)$size)))
  crlf <- grepl("\r\n", txt, fixed = TRUE)
  if (crlf) txt <- gsub("\r\n", "\n", txt, fixed = TRUE)
  list(text = txt, crlf = crlf, lines = split_lines(txt))
}

write_text <- function(path, text, crlf = FALSE) {
  if (crlf) text <- gsub("\n", "\r\n", text, fixed = TRUE)
  writeBin(charToRaw(enc2utf8(text)), path)
}

describe_design <- function(fn_text) {
  s <- norm(fn_text)
  parts <- character()
  m <- regmatches(s, regexec("theme_(bw|classic|minimal|gray|light)\\(", s))[[1]]
  parts <- c(parts, if (length(m)) paste0("theme_", m[2]) else "custom")
  if (grepl("bisque", s, fixed = TRUE)) parts <- c(parts, "bisque frame")
  t <- regmatches(s, regexec("plot\\.title = element_text\\([^)]*?size = (\\d+)", s,
                             perl = TRUE))[[1]]
  if (!length(t))
    t <- regmatches(s, regexec("title = element_text\\(family = \"Alegreya\",size = (\\d+)", s,
                               perl = TRUE))[[1]]
  if (length(t)) parts <- c(parts, sprintf("title %spt", t[2]))
  paste(parts, collapse = ", ")
}

show_file_diff <- function(rel, old_lines, new_lines, max_lines = 80L) {
  a <- tempfile(); b <- tempfile(); on.exit(unlink(c(a, b)))
  writeLines(old_lines, a, useBytes = TRUE); writeLines(new_lines, b, useBytes = TRUE)
  d <- suppressWarnings(system2("git", c("diff", "--no-index", "--no-color", "-U1", a, b),
                                stdout = TRUE, stderr = FALSE))
  h <- grep("^@@", d)
  if (!length(h)) return(invisible())
  cat("\n", sprintf("--- a/%s\n+++ b/%s", rel, rel), "\n", sep = "")
  d <- d[h[1]:length(d)]
  cat(head(d, max_lines), sep = "\n")
  if (length(d) > max_lines) cat("...\n")
}

# ---- Main -------------------------------------------------------------------
consolidate_themes <- function(root = ".", apply = FALSE, report = FALSE,
                               show_diff = 0L, force = FALSE, min_pages = 2L) {
  root <- find_root(root)
  old_wd <- setwd(root); on.exit(setwd(old_wd), add = TRUE)

  # ---- pass 1: collect every chunk that defines theme_custom ----------------
  found <- list()
  for (f in qmd_files()) {
    rd <- read_qmd(f)
    if (!grepl("theme_custom <- function", rd$text, fixed = TRUE)) next
    for (ch in find_chunks(rd$lines)) {
      body <- if (ch$close - ch$open > 1L) rd$lines[(ch$open + 1L):(ch$close - 1L)] else character()
      if (!grepl("theme_custom <- function", paste(body, collapse = "\n"), fixed = TRUE)) next
      info <- analyse_chunk(body)
      if (is.null(info$fn)) next
      found[[length(found) + 1L]] <- list(path = f, open = ch$open, close = ch$close,
                                          info = info, fp = fingerprint(info$fn))
    }
  }
  fps  <- vapply(found, function(x) x$fp, "")
  ufp  <- unique(fps)
  ufp  <- ufp[order(-vapply(ufp, function(u) sum(fps == u), 1L))]   # stable: biggest first
  cat(sprintf("Project root: %s\n", root))
  cat(sprintf("%d theme_custom definitions in %d files, %d distinct designs\n\n",
              length(found), length(unique(vapply(found, function(x) x$path, ""))), length(ufp)))

  # ---- name the designs -----------------------------------------------------
  designs <- list()
  for (fp in ufp) {
    idx <- which(fps == fp); first <- found[[idx[1]]]
    kd  <- KNOWN_DESIGNS[[fp]]
    eligible <- length(idx) >= min_pages
    designs[[fp]] <- list(
      name = if (eligible && !is.null(kd)) kd$name else NULL,
      desc = if (!is.null(kd)) kd$desc else describe_design(first$info$fn),
      fn = first$info$fn, count = length(idx), eligible = eligible)
  }
  cat(sprintf("%-10s %5s  %-26s %s\n", "fingerprint", "pages", "shared name", "design"))
  for (fp in names(designs)) {
    d <- designs[[fp]]
    label <- if (!is.null(d$name)) d$name
             else if (d$eligible) "(unnamed: add to KNOWN_DESIGNS)"
             else "(one-off: left local)"
    cat(sprintf("%-10s %5d  %-26s %s\n", fp, d$count, label, d$desc))
  }
  if (report) return(invisible(designs))

  unnamed <- names(Filter(function(d) d$eligible && is.null(d$name), designs))
  if (length(unnamed))
    stop("Some shared designs have no name yet. Add their fingerprints to ",
         "KNOWN_DESIGNS and re-run: ", paste(unnamed, collapse = ", "), call. = FALSE)

  # ---- pass 2: build replacement chunks -------------------------------------
  edits <- list(); skipped <- list(); residuals <- list(); stubs <- list()
  for (x in found) {
    d <- designs[[x$fp]]
    if (is.null(d$name)) { skipped[[length(skipped) + 1L]] <- x$path; next }
    new_code <- make_stub(d$name, x$info)
    edits[[x$path]] <- c(edits[[x$path]], list(list(open = x$open, close = x$close,
                                                    header = x$info$header, code = new_code)))
    stubs[[x$path]] <- paste(new_code, collapse = "\n")
    if (length(x$info$residual))
      residuals[[x$path]] <- substr(vapply(x$info$residual, norm, ""), 1L, 90L)
  }
  named <- Filter(function(d) !is.null(d$name), designs)
  shared <- build_r_file(unname(named))

  cat(sprintf("\nWould convert %d pages; leave %d untouched.\n", length(stubs), length(skipped)))
  for (p in skipped) cat(sprintf("  skip  %s  [one-off design]\n", p))
  if (length(residuals)) {
    keys <- vapply(residuals, function(r) paste(sort(r, method = "radix"), collapse = "\001"), "")
    cat("\nExtra statements found in those chunks; kept verbatim, ahead of the source() line:\n")
    for (k in unique(keys)[order(-vapply(unique(keys), function(u) sum(keys == u), 1L))]) {
      r <- residuals[[which(keys == k)[1]]]
      cat(sprintf("  %2d pages: %s\n", sum(keys == k), paste(r, collapse = "  |  ")))
    }
  }

  # ---- build the new text of every touched file -----------------------------
  new_files <- list(); removed <- 0L
  for (p in names(edits)) {
    rd <- read_qmd(p); lines <- rd$lines
    for (e in edits[[p]][order(-vapply(edits[[p]], function(z) z$open, 1L))]) {
      lines <- c(lines[seq_len(e$open)], e$header, e$code, lines[e$close:length(lines)])
      # = opening fence, header options, stub, closing fence (old body replaced)
    }
    new_files[[p]] <- list(lines = lines, crlf = rd$crlf, old = rd$lines)
    removed <- removed + (length(rd$lines) - length(lines))
  }

  if (show_diff > 0L)
    for (p in head(sort(names(new_files), method = "radix"), show_diff))
      show_file_diff(p, new_files[[p]]$old, new_files[[p]]$lines)
  cat(sprintf("\nNet lines removed from lesson files: %d\n", removed))

  # ---- parse-check everything we are about to write -------------------------
  cat("\nR syntax check:\n")
  snippets <- c(list("shared-theme-hatter" = shared), stubs)
  bad <- 0L
  for (nm in names(snippets)) {
    err <- tryCatch({ parse(text = snippets[[nm]]); NULL }, error = function(e) conditionMessage(e))
    if (!is.null(err)) { bad <- bad + 1L; cat(sprintf("  PARSE ERROR in %s: %s\n", nm, err)) }
  }
  cat(sprintf("  checked %d snippets, %d errors\n", length(snippets), bad))
  if (bad) stop("R parse errors found; nothing written.", call. = FALSE)

  if (!apply) {
    cat("\nDry run only. Re-run with --apply (or apply = TRUE) to write changes.\n")
    return(invisible(NULL))
  }

  if (!force) {
    st <- suppressWarnings(system2("git", c("status", "--porcelain", "--", "*.qmd", "R"),
                                   stdout = TRUE, stderr = FALSE))
    if (is.null(attr(st, "status")) && length(st))
      stop("Uncommitted changes to .qmd/R files. Commit or stash first (or use force = TRUE).",
           call. = FALSE)
  }

  dir.create("R", showWarnings = FALSE)
  write_text(SHARED_R, shared)
  for (p in names(new_files))
    write_text(p, paste(new_files[[p]]$lines, collapse = "\n"), new_files[[p]]$crlf)
  cat(sprintf("\nWrote %s and rewrote %d files. Review with `git diff --stat`, then re-render.\n",
              SHARED_R, length(new_files)))
  invisible(NULL)
}

# ---- Command-line entry point (Rscript only; skipped when source()d) --------
if (!interactive() && sys.nframe() == 0L) {
  args <- commandArgs(trailingOnly = TRUE)
  flag <- function(f) f %in% args
  value <- function(f, default) {
    i <- match(f, args)
    if (is.na(i) || i == length(args)) default else args[i + 1L]
  }
  consolidate_themes(root = value("--root", "."), apply = flag("--apply"),
                     report = flag("--report"),
                     show_diff = as.integer(value("--diff", 0L)),
                     force = flag("--force"),
                     min_pages = as.integer(value("--min-pages", 2L)))
}
