library(readxl)
summary(Clean)
colnames(Clean)
str(Clean)
library(dplyr)
library(ggplot2)

# Load data
# Define media columns
media <- c("MCC", "PCA", "BEA", "CHAP", "SAB")

##Trend Curves for Each Water Point and Medium

plot_list <- list()

for (m in media) {
  p <- ggplot(Clean, aes(x = `Temps(/Heure)`, y = .data[[m]], color = Lieu)) +
    geom_line() +
    geom_point() +
    labs(title = paste("Tendance de", m, "par point d’eau"),
         x = "Temps (Heure)", y = paste("Charge microbienne sur", m)) +
    theme_minimal()
  
  plot_list[[m]] <- p
}

# View plots one by one
plot_list[["MCC"]]
plot_list[["PCA"]]
plot_list[["BEA"]]
plot_list[["CHAP"]]
plot_list[["SAB"]]



library(tidyverse)

# Liste des milieux
media <- c("MCC", "PCA", "BEA", "CHAP", "SAB")

# Transformer les données au format long
Clean_long <- Clean %>%
  pivot_longer(cols = all_of(media), names_to = "Milieu", values_to = "Charge")

# Créer les graphiques par point de prélèvement
plot_list <- list()

for (lieu in unique(Clean$Lieu)) {
  p <- ggplot(filter(Clean_long, Lieu == lieu),
              aes(x = `Temps(/Heure)`, y = Charge, color = Milieu)) +
    geom_line() +
    geom_point() +
    labs(title = paste("Tendance microbienne pour", lieu),
         x = "Temps (Heure)", y = "Charge microbienne") +
    theme_minimal()
  
  plot_list[[lieu]] <- p
}

# Afficher les graphiques
plot_list[["P1"]]
plot_list[["P2"]]
plot_list[["P3"]]
plot_list[["P4"]]
plot_list[["P5"]]
plot_list[["P6"]]

##Purification Probability (t = 1 as baseline)
purification_prob <- Clean %>%
  group_by(Lieu) %>%
  arrange(`Temps(/Heure)`) %>%
  mutate(across(all_of(media), ~ .x / .x[`Temps(/Heure)` == 1])) %>%
  filter(`Temps(/Heure)` %in% c(2, 3, 4)) %>%
  summarise(across(all_of(media), ~ mean(1 - .x, na.rm = TRUE)))

print(purification_prob)

##Comparaison des populations générales (t = 0 vs t = 4)
general_start <- Clean %>% filter(`Temps(/Heure)` == 0) %>%
  summarise(across(all_of(media), sum))

general_end <- Clean %>% filter(`Temps(/Heure)` == 4) %>%
  summarise(across(all_of(media), sum))

comparison <- bind_rows(Start = general_start, End = general_end, .id = "Time")
print(comparison)

#Individual Media Comparison + P-values
p_values <- sapply(media, function(m) {
  start <- Clean %>% filter(`Temps(/Heure)` == 0) %>% pull(m)
  end <- Clean %>% filter(`Temps(/Heure)` == 4) %>% pull(m)
  t.test(start, end, paired = TRUE)$p.value
})

p_table <- data.frame(Media = media, P_value = round(p_values, 4))
print(p_table)


##Regression: Time + Temperature vs Microbial Load
m <- "CHAP"  # Replace this with "PCA", "MCC", etc. for other media

# Run regression
model <- lm(Clean[[m]] ~ Time + Temp, data = Clean)
summary(model)

# Plot regression curve
ggplot(Clean, aes(x = Time, y = .data[[m]])) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE, color = "blue") +
  labs(title = paste("Régression de", m, "en fonction du temps"),
       x = "Temps (Heure)", y = paste("Charge microbienne sur", m)) +
  theme_minimal()




names(Clean)[names(Clean) == "Temps(/Heure)"] <- "Time"
names(Clean)[names(Clean) == "Temperature(°C)"] <- "Temp"
m <- "CHAP"  # ou "PCA", "MCC", etc.
model <- lm(Clean[[m]] ~ Time + Temp, data = Clean)
summary(model)
ggplot(Clean, aes(x = Time, y = .data[[m]])) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE, color = "blue") +
  labs(title = paste("Régression de", m, "en fonction du temps"),
       x = "Temps (Heure)", y = paste("Charge microbienne sur", m)) +
  theme_minimal()


ggplot(Clean, aes(x = Time, y = CHAP)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE, color = "blue") +
  labs(title = "Régression de CHAP en fonction du temps",
       x = "Temps (Heure)", y = "Charge microbienne (CHAP)") +
  theme_minimal()


library(readxl)
summary(Pho)
colnames(Pho)
str(Pho)
library(dplyr)
library(ggplot2)

