# crosswalk
Pour harmoniser les données françaises entre elles, et notamment les DADS, il est nécessaire d'adapter les géographies et les codes secteurs. Ce repo permet d'obtenir les tables de passages géographiques et sectorielles.

L'immense majorité de ce travail est permise par le travail d'[Antukui](https://antuki.github.io). 

## Crosswalk géographique

Les tables de passages entre années sont issues du fantastique package [COGugaison](https://github.com/antuki/COGugaison). J'ouvre toutes les tables de passage que je joins à la liste des communes en 2022 par rétropolation, jusqu'en 1968.

1.  Ouverture de la base des bassins de vie 2022 dans la géographie 2022 ([INSEE](https://www.insee.fr/fr/information/6676988))

2. Ouverture de la base des zones d'emploi 2020 dans la géographie 2020 ([INSEE](https://www.insee.fr/fr/information/4652957))

3. Ouverture de la base des EPCI 2019 dans la géographie 2019 ([BANATIC](https://www.collectivites-locales.gouv.fr/institutions/liste-et-composition-des-epci-fiscalite-propre))

> [!WARNING]
> Pour les besoins de mes travaux de recherche, je sépare l'EPCI 'Métropole de Paris' et l'EPCI 'Métropole d'Aix-Marseille' en "sous-EPCI", basé sur les EPT composant la Métropole de Paris et sur l'ancienne définition de l'EPCI 'Métropole d'Aix-Marseille' (définition de 2015).
> Pour ne pas séparer, il ne faut pas lancer les lignes 32 à 44 du script `R`.

4. Ouverture de toutes les tables de passage contenues dans `COGugaison`

5. Jointure de toutes les géographies, en partant de la plus récente (2022) et en rétropolant jusque 1968.

La table de passage est disponible en format `.dta` ou `.csv` dans `output/crosswalk_geographies`. 

## Crosswalk des secteurs

Pour l'utilisation des DADS Postes en panel, et notamment pour le passage des années de 1995 à 2008 et après, il faut harmoniser les secteurs. 

Les secteurs DADS pré-2008 sont dans la nomenclature [NES36](https://www.insee.fr/fr/information/2408184#:~:text=La%20NES%20comprend%203%20niveaux,en%20français%20et%20en%20anglais.). Après 2008, il s'agit de la nomenclature [NAF rev.2](https://www.insee.fr/fr/information/2120875). A un tel niveau d'aggrégation, le passage est fait à la main et disponible dans `output/crosswalk_sectors.csv`.