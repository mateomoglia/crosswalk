# crosswalk
Pour harmoniser les données françaises entre elles, et notamment les DADS, il est nécessaire d'adapter les géographies et les codes secteurs. Ce repo permet d'obtenir les tables de passages géographiques et sectorielles.

## Crosswalk géographique

Les tables de passages entre années sont issues du package fantastique de Antuki [COGugaison](https://github.com/antuki/COGugaison). J'ouvre toutes les tables de passage que je joins à la liste des communes en 2022 par rétropolation, jusqu'en 1968.

1.  Ouverture de la base des bassins de vie 2022 dans la géographie 2022 ([INSEE](https://www.insee.fr/fr/information/6676988))

2. Ouverture de la base des zones d'emploi 2020 dans la géographie 2020 ([INSEE](https://www.insee.fr/fr/information/4652957))

3. Ouverture de la base des EPCI 2019 dans la géographie 2019 ([BANATIC](https://www.collectivites-locales.gouv.fr/institutions/liste-et-composition-des-epci-fiscalite-propre))

> [!WARNING]
> Pour les besoins de mes travaux de recherche, je sépare l'EPCI 'Métropole de Paris' et l'EPCI 'Métropole d'Aix-Marseille' en "sous-EPCI", basé sur les EPT composant la Métropole de Paris et sur l'ancienne définition de l'EPCI 'Métropole d'Aix-Marseille' (définition de 2015).
> Pour ne pas séparer, il ne faut pas lancer les lignes 32 à 44 du script `R`.

4. Ouverture de toutes les tables de passage contenues dans `COGugaison`

5. Jointure de toutes les géographies, en partant de la plus récente (2022) et en rétropolant jusque 1968.