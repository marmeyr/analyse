#===============================================================================
# DM2 - Marie Meyer - Linh Chi Vu
#===============================================================================

# Etape 1 : ouvrir le jeu de données
setwd("C:/Users/Marie MEYER/Desktop/master/dm2")

vote <-read.csv2("resultats-par-niveau-burvot-t1-france-entiere.csv", sep=",")

vote <- subset(vote, select = -c(Nom, X.2, X.9, X.16, X.23, X.30, X.37, X.44, X.51, X.58, X.65, X.72,Libellé.du.département, Libellé.de.la.circonscription, Code.du.b.vote, Sexe, X.22, X.29, X.24, X.17, X.10, X.8, X.3, N.Panneau, X, X.1, Prénom, X.31, X.38, X.36, X.7, X.14, X.15, X.21, X.28, X.35, X.42, X.43, X.45, X.49, X.50, X.52, X.56, X.57, X.59, X.63, X.64, X.66, X.70, X.71, X.73))
vote <- subset(vote, select=-c(Code.de.la.commune, Code.de.la.circonscription, Votants, X..Vot.Ins, Blancs, X..Blancs.Ins, X..Blancs.Vot, Nuls, X..Nuls.Ins))
vote <- subset(vote, select=-c(X..Nuls.Vot, Exprimés, X..Exp.Ins, X..Exp.Vot, Voix, X..Voix.Exp, X.4, X.6, X.11, X.13, X.18, X.20, X.25, X.27, X.32, X.34, X.39, X.41, X.46, X.48, X.53, X.55, X.60, X.62, X.67, X.69, X.74, X.76 ))

vote <- vote[vote$Inscrits > 1000, ]

vote <- subset(vote, select= -c(Inscrits, Code.du.département, Abstentions))
vote <- subset(ville, select= -c(Inscrits, Libellé.de.la.commune))

colnames(vote) <- c("Libellé de la commune", "Abstention", "Arthaud", "Roussel", "Macron" , "Lasalle", "LePen", "Zemmour", "Melenchon", "Hidalgo", "Jadot", "Pecresse", "Poutou", "Dupont-Aignant")


str(vote)
unique(vote$Code.du.département) # identitifer les variables non numérique

vote$Code.du.département <- as.integer(vote$Code.du.département) # transformer chr en int
vote$`%Abs/Ins` <- as.integer(vote$`%Abs/Ins`)
vote$`%Vot/Ins` <- as.integer(vote$`%Vot/Ins`)
vote$`%Blancs/Ins` <- as.integer(vote$`%Blancs/Ins`)
vote$`%Blancs/Vot` <- as.integer(vote$`%Blancs/Vot`)
vote$`%Nuls/Ins` <- as.integer(vote$`%Nuls/Ins`)
vote$`%Nuls/Vot` <- as.integer(vote$`%Nuls/Vot`)
vote$`% Exprimés/Ins` <- as.integer(vote$`% Exprimés/Ins`)
vote$`%Exprimés/Vot` <- as.integer(vote$`%Exprimés/Vot`)
vote$`%Voix/Ins` <- as.integer(vote$`%Voix/Ins`)
vote$`%Voix/Exp` <- as.integer(vote$`%Voix/Exp`)
vote$`%Voix/Ins.1` <- as.integer(vote$`%Voix/Ins.1`)
vote$`%Voix/Exp.1` <- as.integer(vote$`%Voix/Exp.1`)
vote$`%Voix/Ins.2` <- as.integer(vote$`%Voix/Ins.2`)
vote$`%Voix/Exp.2` <- as.integer(vote$`%Voix/Exp.2`)
vote$`%Voix/Ins.3` <- as.integer(vote$`%Voix/Ins.3`)
vote$`%Voix/Exp.3` <- as.integer(vote$`%Voix/Exp.3`)
vote$`%Voix/Ins.4` <- as.integer(vote$`%Voix/Ins.4`)
vote$`%Voix/Exp.4` <- as.integer(vote$`%Voix/Exp.4`)
vote$`%Voix/Ins.5` <- as.integer(vote$`%Voix/Ins.5`)
vote$`%Voix/Exp.5` <- as.integer(vote$`%Voix/Exp.5`)
vote$`%Voix/Ins.6` <- as.integer(vote$`%Voix/Ins.6`)
vote$`%Voix/Exp.6` <- as.integer(vote$`%Voix/Exp.6`)
vote$`%Voix/Ins.7` <- as.integer(vote$`%Voix/Ins.7`)
vote$`%Voix/Exp.7` <- as.integer(vote$`%Voix/Exp.7`)
vote$`%Voix/Ins.8` <- as.integer(vote$`%Voix/Ins.8`)
vote$`%Voix/Exp.8` <- as.integer(vote$`%Voix/Exp.8`)
vote$`%Voix/Ins.9` <- as.integer(vote$`%Voix/Ins.9`)
vote$`%Voix/Exp.9` <- as.integer(vote$`%Voix/Exp.9`)
vote$`%Voix/Ins.10` <- as.integer(vote$`%Voix/Ins.10`)
vote$`%Voix/Exp.10` <- as.integer(vote$`%Voix/Exp.10`)
vote$`%Voix/Ins.11` <- as.integer(vote$`%Voix/Ins.11`)
vote$`%Voix/Exp.11` <- as.integer(vote$`%Voix/Exp.11`)

vote$`Arthaud` <- as.integer(vote$`Arthaud`)
vote$`Roussel` <- as.integer(vote$`Roussel`)
vote$`Macron` <- as.integer(vote$`Macron`)
vote$`Lasalle` <- as.integer(vote$`Lasalle`)
vote$`LePen` <- as.integer(vote$`LePen`)
vote$`Zemmour` <- as.integer(vote$`Zemmour`)
vote$`Melenchon` <- as.integer(vote$`Melenchon`)
vote$`Hidalgo` <- as.integer(vote$`Hidalgo`)
vote$`Jadot` <- as.integer(vote$`Jadot`)
vote$`Pecresse` <- as.integer(vote$`Pecresse`)
vote$`Poutou` <- as.integer(vote$`Poutou`)
vote$`Dupont-Aignant` <- as.integer(vote$`Dupont-Aignant`)
vote$`Abstention` <- as.integer(vote$`Abstention`)
vote$`Code du département`<-as.integer(vote$`Code du département`)

# supprimer lignes avec valeurs manquantes
vote <- na.omit(vote)
#--------------------------------

# faire clusther
library(FactoMineR)
pca <- PCA(vote, quali.sup=1)
pca <- PCA(vote, quali.sup = 1, ncp = 4)
vote.clust <- HCPC(pca)

vote.clust$data.clust

vote.clust$desc.var







agn <- agnes(vote, metric="manhattan", stand=TRUE)
plot(agn, ask = FALSE, which.plots = 2)

# on découpe en 3 classes
nbClasses <- 3
Clusters <- cutree(tree = agn, k = nbClasses)
source("http://addictedtor.free.fr/packages/A2R/lastVersion/R/code.R")
ordreClasses <- unique(Clusters[agn$order])
cPal <- c(1:nbClasses)[ordreClasses]

A2Rplot(x = as.hclust(agn),k = nbClasses, boxes = FALSE, col.up = "gray50",col.down = cPal,show.labels = FALSE, main = "Dendrogramme")

legend(x="topleft", paste("Cluster", 1:nbClasses, sep=" "),cex=1,seg.len=4,col=cPal,pch=NA,lty=1, lwd=4)
