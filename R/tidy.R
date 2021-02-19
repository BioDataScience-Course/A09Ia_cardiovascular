# Packages
SciViews::R
# Importation des données
cardiovascular <- read("data/raw/cardiovascular.csv")

str(cardiovascular)
summary(cardiovascular)

# Utilisation des informations proposées avec les données afin d'ajouter des labels et unité à nos variables

cardiovascular %>.%
  mutate(.,
    height = height/100,
    gender = factor(gender, levels = c(1, 2), labels = c("woman", "man")),
    cholesterol = factor(cholesterol, levels = c(1,2,3), labels = c("normal", "above normal", "well above normal")),
    gluc = factor(gluc, levels = c(1,2,3), labels = c("normal", "above normal", "well above normal")),
    smoke = factor(smoke, levels = c(0, 1), labels = c("non-smoking", "smoking")),
    alco = factor(alco, levels = c(0,1), labels = c("non-drinker", "drinker")),
    active = factor(active, levels = c(0,1), labels = c("non-active", "active")),
    cardio = factor(cardio, levels = c(0,1), labels = c("absence", "presence"))) %>.%
  labelise(.,
    label = list(
      age = "Age", height = "Taille", gender = "Genre",
      weight = "Masse", ap_hi = "Pression systolique", ap_lo = "Pression diastolique",
      cholesterol = "Taux de cholestérol", gluc = "Taux de glucose", smoke = "Fumeur",
      alco = "Consommation d'alcool", active = "Activité physique", cardio = "Maladie cardio-vasculaire"),
    units = list(
      age = "j", height = "m", weight = "kg",
      ap_hi = "mmHg", ap_lo = "mmHg")) -> cardio

summary(cardio)

write(cardio, "data/cardio.rds", compress = "xz", type = "rds")
