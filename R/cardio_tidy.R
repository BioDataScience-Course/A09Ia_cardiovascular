# Remaniement des données brutes sur les maladies cardiovasculaires.
# Date : 8 mars 2023
## Note: Le jeu de données `data/cardio.rds` est déjà créé pour vous.
## Vous ne devez pas exécuter ce script. Cependant, nous le laissons ici afin
## que vous puissiez voir comment le jeu de données brut a été retravaillé.

# Packages utiles ----
SciViews::R

# Importation des données brutes ----
cardiovascular <- read("data/raw/cardiovascular.csv.xz")

# Vérification du type des variables, Ajouts des labels et unités ----
cardiovascular %>.%
  smutate(., # Variables dans des formats corrects
    height      = height / 100,
    gender      = factor(gender, levels = c(1, 2),
      labels = c("woman", "man")),
    cholesterol = factor(cholesterol, levels = c(1, 2, 3),
      labels = c("normal", "above normal", "well above normal")),
    gluc        = factor(gluc, levels = c(1, 2, 3),
      labels = c("normal", "above normal", "well above normal")),
    smoke      = factor(smoke, levels = c(0, 1),
      labels = c("non-smoking", "smoking")),
    alco       = factor(alco, levels = c(0, 1),
      labels = c("non-drinker", "drinker")),
    active     = factor(active, levels = c(0, 1),
      labels = c("non-active", "active")),
    cardio     = factor(cardio, levels = c(0, 1),
      labels = c("absence", "presence"))) %>.%
  labelise(., # Ajout des labels et unités aux variables
    label = list(
      age = "Age", height = "Taille", gender = "Genre",
      weight = "Masse", ap_hi = "Pression systolique",
      ap_lo = "Pression diastolique", cholesterol = "Taux de cholestérol",
      gluc = "Taux de glucose", smoke = "Fumeur",
      alco = "Consommation d'alcool", active = "Activité physique",
      cardio = "Maladie cardio-vasculaire"),
    units = list(
      age = "j", height = "m", weight = "kg",
      ap_hi = "mmHg", ap_lo = "mmHg")) ->
  cardio

summary(cardio)

# Sélection aléatoire de 10 000 individus atteint ou non de maladie cardio-vasculaire. ----
set.seed(992)

cardio %>.%
  group_by(., cardio, gender) |> slice_sample(n = 5000) %->%
  cardio

table(cardio$gender, cardio$cardio)

# Sauvegarde du tableau ----
write$rds(cardio, "data/cardio.rds", compress = "xz")

# Nettoyage de l'environnement global ----
rm(cardiovascular, cardio)
