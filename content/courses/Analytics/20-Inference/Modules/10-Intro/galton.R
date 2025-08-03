library(mosaic)
library(patchwork)
library(cowplot)
library(ggformula)
data("Galton")
inspect(Galton)

#### Plots ####

p1 <- gf_jitter(height ~ sex,data = Galton, alpha = 0.3,title = "Quantitative Response, Qualitative Explanatory",width = 0.2, height = 0.2, xlab = "Child's Sex", ylab = "Child's Height") %>% gf_theme(theme = ggthemes::theme_tufte(base_size = 8))
p1


p2 <- gf_point(height ~ mother ,data = Galton, alpha = 0.3,title = "Quantitative Response, Quantitative Explanatory", xlab = "Mother's Height", ylab = "Child's Height")%>% gf_theme(theme = ggthemes::theme_tufte(base_size = 8))
p2


p3 <- gf_jitter(sex ~ mother ,data = Galton, alpha = 0.3,title = "Qualitative Response, Quantitative Explanatory",width = 0.2, height = 0.2, xlab = "Mother's Height", ylab = "Child's Sex")%>% gf_theme(theme = ggthemes::theme_tufte(base_size = 8))
p3


p4 <- gf_jitter(sex ~ nkids,data = Galton, alpha = 0.3,title = "Qualitative Response, Qualitative Explanatory", height = 0.2, width = 0, ylab = "Child's Sex", xlab = "Family Child Count (Categorical!)") %>% gf_theme(theme = ggthemes::theme_tufte(base_size = 8))
p4


plot_grid(p1, p2, p3, p4, labels = c('A', 'B', "C", "D"), label_size = 12,scale = 0.8, align = "hv") %>% ggsave2(filename = "./content/courses/8-Data-Analytics/20-Basics-of-Modeling/Models.png")

