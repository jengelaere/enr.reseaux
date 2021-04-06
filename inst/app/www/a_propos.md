---
output: 
 html_document: 
	 smart: no
	 toc: yes
---

<link href="www/style.css" rel="stylesheet"></link>

L’Observatoire de la Transition Écologique (TEO) a pour mission d’améliorer la connaissance territoriale sur l’énergie et le climat en Pays de la Loire. La DREAL Pays de la Loire et TEO ont collaboré pour créer cette application de datavisualisation et de téléchargement de données relatives aux énergies renouvelables de réseaux. Les données ici présentées sont principalement issues des gestionnaires de réseaux d’énergie (GRDF, GRTgaz, Enedis et RTE en Pays de la Loire).

D’autres outils et des données supplémentaires sont disponibles sur le site de TEO :  <a href="http://teo-paysdelaloire.fr" target="_blank">teo-paysdelaloire.fr</a>.   

## Code source
L’ensemble des scripts de collecte et de datavisualisation est disponible sur le <a href="https://gitlab.com/dreal-datalab/enr_reseaux_teo" target="_blank">répertoire gitlab du DREAL datalab</a>. Vous pouvez y reporter les éventuels bugs ou demandes d'évolution au niveau de la rubrique <a href="https://gitlab.com/dreal-datalab/poc-enr-teo/issues" target="_blank">Issue</a>.   
 
## Concepts et définitions  
**Objectifs** : les objectifs affichés correspondent aux objectifs inscrits dans le schéma régional climat, air énergie approuvé le 18 avril 2014 et disponible <a href="http://www.pays-de-la-loire.developpement-durable.gouv.fr/adoption-du-schema-regional-climat-air-energie-a2641.html" target="_blank">sur le site de la DREAL</a>.  
Ces objectifs seront révisés dans le cadre du SRADDET à venir.  

La **notion d’installation** utilisée ici correspond selon la source à la notion de point de raccordement pour Enedis et à un producteur pour le registre : pour une installation solaire photovoltaïque ou hydro-électrique, il n’y a priori qu’un seul point de raccordement par installation, aussi ces deux notions se confondent. En revanche, pour la filière éolienne les choses sont plus nuancées et le nombre de points de raccordement reflète moins bien le nombre d’installations : un parc éolien de plusieurs mâts peut disposer d’un à deux points de raccordement (ex le parc éolien des Touches - SYSCOM de 15 MW correspond à deux points de raccordement pour le gestionnaire de réseau : le PARC EOLIEN DES TOUCHES 1 de 10 MW et le PARC EOLIEN DES TOUCHES 2 de 5 MW) ou à l’inverse un point de raccordement peut représenter une unique petite éolienne domestique.


**Energie de récupération**: par convention, l’énergie produite à base de déchets est considérée à 50 % comme renouvelable (source directive européenne sur la comptabilisation des ENR, 2009/28/CE, du 23 avril 2009).


## Les sources de données mobilisées    

#### Registre national des installations de production d'électricité et de stockage
Le <a href="https://opendata.reseaux-energies.fr/explore/?sort=modified&q=registre-national-installation-production-stockage-electricite-agrege" target="_blank">registre national des installations de production d’électricité</a>  est publié par RTE via la plateforme Open Data Réseaux Énergies (ODRÉ). Ce jeu de données, arrêté au 31 décembre de chaque année, recense et décrit les installations de production d’électricité (capacité, productible, date de mise en service) de plus de 36 kW,. Il est diffusé en vertu de l'<a href="https://www.legifrance.gouv.fr/affichCodeArticle.do?cidTexte=LEGITEXT000023983208&idArticle=LEGIARTI000031055892&dateTexte=29990101&categorieLien=cid" target="_blank">article L.142-9-1 du code de l'énergie</a> et conformément aux dispositions de l'<a href="https://www.legifrance.gouv.fr/eli/arrete/2016/7/7/DEVR1619667A/jo/texte/fr" target="_blank">arrêté du 7 juillet 2016</a>.  
Ces données sont utilisées par l'application pour construire l’état des lieux le plus récent et complet des installations de productions d'électricité renouvelable, elles servent notamment à connaître le nombre d'installations et les puissances raccordées en fin d'année à partir de 2018. Il y est fait référence par la mention "Source : Registre".  

#### Enedis  

Cette application se base également sur un fichier à façon fourni par Enedis et sur l'opendata d'Enedis. Le fichier à façon est utilisé pour connaître les productions, l’évolution des puissances installées et du nombre d’installations de 2011 à 2017. Ce fichier ne couvre pas les communes des régions limitrophes appartenant à un EPCI à cheval sur les Pays de la Loire et une autre région. 
 
Les données en open data, intitulées <a href="https://data.enedis.fr/explore/dataset/production-electrique-par-filiere-a-la-maille-commune/information/" target="_blank">Production électrique annuelle par filière à la maille commune</a> sont utilisées pour connaître la production annuelle à partir de 2018. 

Il est fait référence à ces données par la mention "Source : Enedis". 

#### SDES
Les <a href="https://www.statistiques.developpement-durable.gouv.fr/donnees-locales-de-consommation-denergie?rubrique=23&dossier=189" target="_blank">consommations de gaz et d’électricité</a> sont fournies par le Service de la donnée et des études statistiques (SDES) du Ministère de la Transition Écologique. Elles sont utilisées pour calculer l'indicateur d'autonomie énergétique renouvelable : production renouvelable / consommation. Il est fait référence à ces données par la mention "Source : SDES".  
Ces jeux de données mis en ligne par le SDES sont le fruit d'une enquête menée en application de l'<a href="https://www.legifrance.gouv.fr/eli/loi/2015/8/17/2015-992/jo/article_179" target="_blank">article 179</a> de la loi relative à la transition énergétique pour la croissance verte de 2015 auprès des gestionnaires de réseaux.

#### Points d'injections de biométhane et injections annuelles
La <a href="https://opendata.reseaux-energies.fr/explore/dataset/points-dinjection-de-biomethane-en-france/information/?disjunctive.site&disjunctive.departement&disjunctive.region&disjunctive.type_de_reseau&disjunctive.grx_demandeur" target="_blank">liste des points d'injection de biométhane</a> est originellement publiée par GRTgaz sur la plateforme ODRE.
Cette liste a été croisée et enrichie grâce aux <a href="https://opendata.grdf.fr/explore/dataset/capacite-et-quantite-dinjection-de-biomethane" target="_blank">données annuelles d'injection publiées par GRDF</a> sur sa plateforme opendata.


#### Date de publication des données traitées

<table>
<colgroup>
<col style="width: 52%" />
<col style="width: 15%" />
<col style="width: 12%" />
<col style="width: 21%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">Dataset</th>
<th style="text-align: center;">Millésime</th>
<th style="text-align: center;">Producteur</th>
<th style="text-align: center;">Date de publication</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">registre électricité</td>
<td style="text-align: center;">311217</td>
<td style="text-align: center;">ODRE</td>
<td style="text-align: center;">2019-10-14</td>
</tr>
<tr class="even">
<td style="text-align: left;">registre électricité</td>
<td style="text-align: center;">311218</td>
<td style="text-align: center;">ODRE</td>
<td style="text-align: center;">2019-12-12</td>
</tr>
<tr class="odd">
<td style="text-align: left;">registre électricité</td>
<td style="text-align: center;">311219</td>
<td style="text-align: center;">ODRE</td>
<td style="text-align: center;">2020-06-01</td>
</tr>
<tr class="even">
<td style="text-align: left;">productions électriques à la maille iris</td>
<td style="text-align: center;">2011 à 2019</td>
<td style="text-align: center;">Enedis</td>
<td style="text-align: center;">2020-10-07</td>
</tr>
<tr class="odd">
<td style="text-align: left;">productions électriques à la maille commune</td>
<td style="text-align: center;">2011 à 2019</td>
<td style="text-align: center;">Enedis</td>
<td style="text-align: center;">2020-10-07</td>
</tr>
<tr class="even">
<td style="text-align: left;">productions électriques à la maille epci</td>
<td style="text-align: center;">2011 à 2019</td>
<td style="text-align: center;">Enedis</td>
<td style="text-align: center;">2020-10-07</td>
</tr>
<tr class="odd">
<td style="text-align: left;">productions électriques à la maille departement</td>
<td style="text-align: center;">2011 à 2019</td>
<td style="text-align: center;">Enedis</td>
<td style="text-align: center;">2020-10-07</td>
</tr>
<tr class="even">
<td style="text-align: left;">productions électriques à la maille region</td>
<td style="text-align: center;">2011 à 2019</td>
<td style="text-align: center;">Enedis</td>
<td style="text-align: center;">2020-10-07</td>
</tr>
<tr class="odd">
<td style="text-align: left;">points-dinjection-de-biomethane-en-france</td>
<td style="text-align: center;">en cours 2020</td>
<td style="text-align: center;">GRTgaz</td>
<td style="text-align: center;">2020-10-07</td>
</tr>
<tr class="even">
<td style="text-align: left;">capacite-et-quantite-dinjection-de-biomethane</td>
<td style="text-align: center;">en cours 2020</td>
<td style="text-align: center;">GRDF</td>
<td style="text-align: center;">2020-03-05</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Données locales de consommations électriques et gaz</td>
<td style="text-align: center;">2008 à 2019</td>
<td style="text-align: center;">SDES</td>
<td style="text-align: center;">2020-10-01</td>
</tr>
</tbody>
</table>


## Description des fichiers téléchargeables  
Il est possible, via la section « Téléchargement » de l’application, d’exporter les jeux de données utilisés pour présenter les résultats.  
Ces fichiers contiendront les données du territoire sélectionné dans le menu en haut à gauche, et des données des échelles inférieures et supérieures qui s'y rapportent.  
Les jeux de données diffèrent des sources.   

En effet, plusieurs opérations ont été effectuées afin de faciliter la réutilisation des données par les acteurs territoriaux, principalement :  

* simplification des dessins de fichier,  
* redressement de données, estimation de la valeur des données manquantes,  
* mise à jour de la géographie (IRIS, Communes, EPCI) sur tous les jeux,  
* calcul de données de synthèse, d'indicateurs, reconstruction des totaux des échelles territoriales supérieures,  
* contrôle de cohérence par croisement de sources.  

Pour plus de détails sur la démarche, fichier par fichier, il est possible de récupérer le code source de l’application (cf. Code source) et de contacter les équipes en charge du sujet (cf. Contact).  
   
<br>   

**Cinq jeux de données sont téléchargeables** :    

- *Registre des installations électriques renouvelables* : Inventaire des installations par territoire et la puissance installée pour la dernière année disponible. Ce fichier est issu du registre retravaillé.  

-  _Points d'injection de biométhane_ : Liste des points d'injection de biométhane par territoire et caractéristiques techniques de ces derniers : capacité d'injection, type d'installation, date de mise en service... (nota : la mention "bioch4" dans l'intitulé des colonne signifie biométhane)   

-  _Productions et capacités raccordées_ : Suivi du nombre d’installations, des puissances installées et des productions permettant d’obtenir l’évolution sur l’ensemble des années disponibles. Ce fichier est issu des données demandées à Enedis par la DREAL et TEO.  

-  _Injections annuelles de biométhane_ : Suivi annuel 2013-2018 des capacités d'injections et des quantitées de biométhane réellement injectées sur le réseau du territoire. Ce fichier est issu du jeu de données publié par GRDF et d'estimations réalisées par la DREAL pour la production des installations ne relevant pas du réseau de GRDF.   

-  _Consommation et part EnR&R_ : Suivi des consommations électrique/gaz du territoire, par rapport à sa production ou à ses injections, pour la dernière année disponible.   



## Remerciements  
La DREAL et TEO remercient chacun des gestionnaires de réseaux d’énergie, **Enedis**, **GRDF**, **GRTgaz** et **RTE** pour la production des données mais également pour la qualité des échanges techniques liés à la réutilisation de ces ressources et la réceptivité des équipes vis-à-vis des questions soulevées lors du projet.


## Contacts
Observatoire de la Transition Écologique – Pays de la Loire (TEO) : contact [at] teo-paysdelaloire.fr     
Mission Énergie et Changement Climatique de la DREAL des Pays de la Loire : mecc.dreal-pays-de-la-loire [at] developpement-durable.gouv.fr   
Signalement de bugs et demandes d'évolution : <a href="https://gitlab.com/dreal-datalab/poc-enr-teo/issues" target="_blank">répertoire Gitlab de l'application</a>  

## Mentions légales  
Publié le 22 mai 2019  - mis à jour le 24 novembre 2020

#### Service gestionnaire  
Direction Régionale de l’Environnement de l’Aménagement et du Logement des Pays de la Loire  
5, rue Françoise Giroud - CS 16326  
44263 NANTES Cedex 2  
Tél : 02 72 74 73 00 
Courriel : dreal-paysdelaloire [at] developpement-durable.gouv.fr  

#### Directrice de publication  
Annick Bonneville, directrice régionale de l’environnement, de l’aménagement et du logement des Pays de la Loire.

#### Conception, réalisation  
- Développement : DREAL Pays de la Loire
- Feuille de styles CSS : <a href="http://www.johndoe-et-fils.com" target="_blank">John Doe et Fils</a> – Agence de Communication Digitale, 144 Rue Paul Bellamy – 44000 Nantes

#### Hébergement  
Rstudio - <a href="http://shinyapps.io" target="_blank">plateforme Shinyapps</a>

#### Droit d’auteur - Licence
Tous les contenus présents sur ce site sont couverts par le droit d’auteur.  
Toutes les informations liées à cette application (données, scripts...) sont publiées sous <a href="https://gitlab.com/dreal-datalab/poc-enr-teo/blob/master/LICENSE.md" target="_blank">licence ouverte/open licence v2</a> (dite licence Etalab) : quiconque est libre de réutiliser ces informations, sous réserve notamment, d'en mentionner la filiation.

#### Établir un lien  
- Tout site public ou privé est autorisé à établir, sans autorisation préalable, un lien vers les informations diffusées par le Ministère de la Transition écologique et solidaire.  
- L’autorisation de mise en place d’un lien est valable pour tout support, à l’exception de ceux diffusant des informations à caractère polémique, pornographique, xénophobe ou pouvant, dans une plus large mesure porter atteinte à la sensibilité du plus grand nombre.  
- Pour ce faire, et toujours dans le respect des droits de leurs auteurs, une <a href="http://www.pays-de-la-loire.developpement-durable.gouv.fr/local/cache-vignettes/L106xH136/arton1255-60fd5.jpg" target="_blank">icône "Marianne"</a> peut être utilisée pour agrémenter votre lien et préciser que le site d’origine est celui de la DREAL Pays de la Loire.

#### Usage  
- Les utilisateurs sont responsables des interrogations qu’ils formulent ainsi que de l’interprétation et de l’utilisation qu’ils font des résultats. Il leur appartient d’en faire un usage conforme aux réglementations en vigueur et aux recommandations de la CNIL lorsque des données ont un caractère nominatif (loi n° 78.17 du 6 janvier 1978, relative à l’informatique, aux fichiers et aux libertés dite loi informatique et libertés).  
- Il appartient à l’utilisateur de ce site de prendre toutes les mesures appropriées de façon à protéger ses propres données et/ou logiciels de la contamination par d’éventuels virus circulant sur le réseau Internet. De manière générale, la Direction Régionale de l’Environnement de l’Aménagement et du Logement des Pays de la Loire décline toute responsabilité à un éventuel dommage survenu pendant la consultation du présent site. Les messages que vous pouvez nous adresser transitant par un réseau ouvert de télécommunications, nous ne pouvons assurer leur confidentialité.
