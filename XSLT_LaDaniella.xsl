<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">

    <!-- Configuration de la sortie HTML, avec indentation automatique, et encodage UTF-8 -->
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <!-- Gestion des espaces non voulus -->
    <xsl:strip-space elements="*"/> 
    
    
    
    
    <!-- DÉFINITIONS DES VARIABLES -->
    
    <!-- VARIABLES contenant du texte -->
    <!-- la variable 'title' stocke le titre du roman-feuilleton -->
    <xsl:variable name="title">
            <xsl:value-of select="//fileDesc/titleStmt/title"/>
    </xsl:variable>
    
    <!-- la variable 'author' stocke le prénom et le nom de l'auteur du roman-feuilleton -->
    <xsl:variable name="author">
        <xsl:value-of select="concat(//fileDesc/titleStmt//forename, ' ', //fileDesc/titleStmt//surname)"/>
    </xsl:variable>
    
    <!-- la variable 'authorTEI' stocke le prénom et le nom de l'auteur de l'encodage du roman-feuilleton -->
    <xsl:variable name="authorTEI">
        <xsl:value-of select="concat(//editionStmt//forename, ' ', //editionStmt//surname)"/>
    </xsl:variable>
    
    
    <!-- VARIABLES contenant les chemins de fichier -->
    <!-- la variable 'witfile' stocke le nom et le chemin du fichier courant -->
    <xsl:variable name="witfile">     
        <xsl:value-of select="replace(base-uri(.), 'TEI_LaDaniella_FL.xml', '')"/>
    </xsl:variable>
    
    <!-- Définitions des variables contenant le chemin des sorties HTML -->
    <xsl:variable name="chemin_pageAccueil">
        <xsl:value-of select="concat($witfile, 'html/pageAccueil', '.html')"/>
    </xsl:variable>
    
    <xsl:variable name="chemin_metadonnees">
        <xsl:value-of select="concat($witfile, 'html/metadonnees', '.html')"/>
    </xsl:variable>
    
    <xsl:variable name="chemin_projet">
        <xsl:value-of select="concat($witfile, 'html/projet', '.html')"/>
    </xsl:variable>
    
    <xsl:variable name="chemin_consignes">
        <xsl:value-of select="concat($witfile, 'html/consignes', '.html')"/>
    </xsl:variable>
    
    <xsl:variable name="chemin_transcription">
        <xsl:value-of select="concat($witfile, 'html/transcription', '.html')"/>
    </xsl:variable>
    
    <xsl:variable name="chemin_transcription_enrichie">
        <xsl:value-of select="concat($witfile, 'html/transcription_enrichie', '.html')"/>
    </xsl:variable>
    
    <xsl:variable name="chemin_pers_index">
        <xsl:value-of select="concat($witfile, 'html/pers_index', '.html')"/>
    </xsl:variable>
    
    <xsl:variable name="chemin_place_index">
        <xsl:value-of select="concat($witfile, 'html/place_index', '.html')"/>
    </xsl:variable>
    
    <xsl:variable name="chemin_relations_perso">
        <xsl:value-of select="concat($witfile, 'html/relations_perso', '.html')"/>
    </xsl:variable>
    
    <xsl:variable name="chemin_fiche_perso">
        <xsl:value-of select="concat($witfile, 'html/fiche_descriptive_perso', '.html')"/>
    </xsl:variable>
    
    <xsl:variable name="chemin_fiche_lieu">
        <xsl:value-of select="concat($witfile, 'html/fiche_descriptive_lieu', '.html')"/>
    </xsl:variable>
        
    
    <!-- VARIABLES contenant la structure générale pour les sorties HTML -->
    <!-- Création de l'en-tête HTML -->
    <xsl:variable name="head">
        <head>
            <meta http-equiv="Content-Type" content="text/html" charset="UTF-8"/>
            <meta name="description"
                content="Projet d'édition numérique du roman-feuilleton {$title}  de {$author}"/>
            <meta name="keywords" content="edition, roman-feuilleton, xml, tei, xslt"/>
            <meta name="author" content="{$authorTEI}"/>
            <!-- Utilisation de Boostsrap 5.0 pour le design -->
            <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"/>
            <link
                href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
                rel="stylesheet"
                integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
                crossorigin="anonymous"/>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"/>
        </head>
    </xsl:variable>
    
    <!-- Création de la barre de navigation -->
    <xsl:variable name="nav_bar">
        <nav class="navbar navbar-expand-md navbar-dark mb-4" style="background-color: #6495ED;">
            <a class="navbar-brand" style="padding-left: 5px" href="{$chemin_pageAccueil}">
                <!-- On récupère le titre de l'oeuvre, le prénom et le nom de l'auteur dans la source XML en utilisant les variables définies précédemment -->
                <xsl:value-of select="concat($title, ' de ', $author)"/>
            </a>
            
            <ul class="navbar-nav mr-auto">
                <!-- Ensemble des menus déroulants renvoyant vers les bonnes pages à l'aide des variables contenant les chemins définies précédemment -->
                <div class="dropdown">
                    <button class="btn btn-outline-light dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                        Projet d'édition
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                        <li><a class="dropdown-item" href="{$chemin_metadonnees}">Métadonnées</a></li>
                        <li><a class="dropdown-item" href="{$chemin_projet}">Projet</a></li>
                        <li><a class="dropdown-item" href="{$chemin_consignes}">Consignes</a></li>
                    </ul>
                </div>

                <div class="dropdown">
                    <button class="btn btn-outline-light dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                        Types de transcription
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                        <li><a class="dropdown-item" href="{$chemin_transcription}">Transcription brute</a></li>
                        <li><a class="dropdown-item" href="{$chemin_transcription_enrichie}">Transcription enrichie</a></li>
                    </ul>
                </div>
                
                <div class="dropdown">
                    <button class="btn btn-outline-light dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                        Index
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                        <li><a class="dropdown-item" href="{$chemin_pers_index}">Index des personnages</a></li>
                        <li><a class="dropdown-item" href="{$chemin_place_index}">Index des lieux</a></li>
                    </ul>
                </div>
                
                <div class="dropdown">
                    <button class="btn btn-outline-light dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                        Analyses contextuelles
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                        <li><a class="dropdown-item" href="{$chemin_relations_perso}">Relations entre les personnages</a></li>
                        <li><a class="dropdown-item" href="{$chemin_fiche_perso}">Fiche descriptive des personnages</a></li>
                        <li><a class="dropdown-item" href="{$chemin_fiche_lieu}">Fiche descriptive des lieux</a></li>
                    </ul>
                </div>
            </ul>
        </nav>
    </xsl:variable>
    
    <!-- Création du pied-de-page -->
    <xsl:variable name="footer">
        <footer class="bg-light text-center text-lg-start">
            <div class="text-center p-3 text-white" style="background-color: #6495ED; font-size: 18px">
                <p>Fanny Lebreton - 2022</p>
            </div>
        </footer>
    </xsl:variable>
    
    
    
    
    <!-- SORTIES HTML -->
    <xsl:template match="/">
        
        <!-- Sortie HTML de la page accueil -->
        <xsl:result-document href="{$chemin_pageAccueil}" method="html" indent="yes">
            <html>
                <!-- Métadonnées copiées à l'aide de la variable 'head' définie précédemment -->
                <xsl:copy-of select="$head"/>
                <body>
                    <!-- Barre de navigation copiée à l'aide de la variable 'nav_bar' définie précédemment -->
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container">
                        <div class="text-center">
                            <h1>Bienvenue sur l'édition numérique du roman-feuilleton <i>La Daniella</i> de George Sand !</h1>
                            <br/>
                            <p>L'extrait édité correspond à l'épisode paru dans le numéro du <b>12 janvier 1857</b> du quotidien <i>La Presse</i>. 
                                L'épisode contient <b>la fin du chapitre V et le chapitre VI</b> de l'oeuvre.</p>
                            <p>La numérisation est disponible sur <a href="https://gallica.bnf.fr/accueil/en/content/accueil-en?mode=desktop">Gallica</a> à cette <a href="{//sourceDesc//publicationStmt/distributor/@facs}">adresse</a>.</p>
                        </div>
                        <br/>
                        <hr/>
                        <br/>
                        <div>
                            <h3 class="text-center">Fonctionnement de l'édition</h3>
                            <p>Il est possible de naviguer dans cette édition grâce à la barre de navigation. Celle-ci met en avant <b>4 rubriques consultables</b>, divisées en sous-champs :</p> 
                            <ul>
                                <li>La rubrique <b>Projet d'édition</b> contient : 
                                    <ul>
                                        <li>les métadonnées,</li> 
                                        <li>le projet,</li> 
                                        <li>les consignes.</li>
                                    </ul>
                                </li>
                                <li>La rubrique <b>Types de transcription</b> contient : 
                                    <ul>
                                        <li>la transcription brute,</li> 
                                        <li>la transcription enrichie.</li> 
                                    </ul>
                                </li>
                                <li>La rubrique <b>Index</b> contient : 
                                    <ul>
                                        <li>l'index des noms des personnages,</li> 
                                        <li>l'index des noms des lieux.</li> 
                                    </ul>
                                </li>
                                <li>La rubrique <b>Analyses contextuelles</b> contient 3 analyses : 
                                    <ul>
                                        <li>les relations entre les personnages,</li> 
                                        <li>la fiche descriptive des personnages,</li> 
                                        <li>la fiche descriptive des lieux,</li> 
                                    </ul>
                                </li>
                            </ul>
                            <p class="text-center"><b>Bonne consultation !</b></p>
                        </div>
                    </div>
                    <!-- Pied de page copié à l'aide de la variable 'footer' définie précédemment -->
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
        
        
        <!-- RUBRIQUE 'Projet d'édition' -->
        
        <!-- Sortie HTML de la page métadonnées -->
        <xsl:result-document href="{$chemin_metadonnees}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container">
                        <h1 class="text-center">Informations bibliographiques</h1>
                        <br/>
                        <h3 class="text-center">Source d'origine</h3>
                        <br/>
                        <ul>
                            <li><b>Titre</b> : <xsl:value-of select="$title"/></li>
                            <li><b>Auteur</b> : <a href="{//fileDesc/titleStmt/author/@ref}"><xsl:value-of select="$author"/></a></li>
                            <br/>
                            <li><b>Publication</b> : <xsl:value-of select="//biblFull/publicationStmt/publisher"/></li>
                            <li><b>Lieu</b> : <xsl:value-of select="//biblFull/publicationStmt/pubPlace//settlement"/></li>
                            <li><b>Autorité(s) de publication</b> : <xsl:value-of select="//biblFull/publicationStmt/authority/persName/surname"/></li>
                            <br/>
                            <li><b>Date de publication</b> : <xsl:value-of select="//biblFull/publicationStmt/date"/></li>
                            <li><b>Épisode</b> : <xsl:value-of select="//biblFull/seriesStmt/biblScope[@unit = 'chapter']"/></li>
                            <li><b>Page(s)</b> : <xsl:value-of select="//biblFull/seriesStmt/biblScope[@unit = 'page']"/></li>
                            <br/>
                            <li><b>Numérisation mise à disposition par</b> : <a href="{//biblFull/publicationStmt/distributor/@facs}"><xsl:value-of select="//biblFull/publicationStmt/distributor"/></a></li>
                        </ul>
                        <br/>
                    </div>
                    <div class="container">
                        <h3 class="text-center">Édition numérique</h3>
                        <br/>
                        <ul>
                            <li><b>Titre</b> : <xsl:value-of select="$title"/></li>
                            <li><b>Auteur</b> : <a href="{//fileDesc/titleStmt/author/@ref}"><xsl:value-of select="$author"/></a></li>
                            <br/>
                            <li><b>Transcription et encodage réalisés par</b> : <xsl:value-of select="$authorTEI"/></li>
                            <li><b>Date</b> : <xsl:value-of select="//fileDesc/editionStmt/edition/date"/></li>
                            <li><b>Lieu</b> : <xsl:value-of select="//fileDesc/publicationStmt/pubPlace//settlement"/></li>
                            <li><b>Contexte</b> : <xsl:value-of select="//fileDesc/editionStmt/edition/text()"/></li>
                            <li><b>Disponible sur</b> : dépôt <a href="{//fileDesc/publicationStmt/publisher/@ref}">Github</a></li>
                        </ul>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- Sortie HTML de la page projet -->
        <xsl:result-document href="{$chemin_projet}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container">
                        <h1 class="text-center">Objectifs du projet</h1>
                        <br/>
                        <h3 class="text-center">Projet initial de l'encodage TEI</h3>
                        <br/>
                        <p>Les choix initiaux d'encodage TEI appliqués sur le texte répondent à <b>divers objectifs</b>.</p>
                        <p><xsl:value-of select="//encodingDesc/p[2]"/></p>
                        <p><xsl:value-of select="//encodingDesc/p[3]"/></p>
                        <p>Pour plus de renseignements sur les objectifs scientifiques de l'édition et les détails de l'encodage, nous vous conseillons de consulter l'ODD suivante : <b>'ODD_LaDaniella_FL'</b>.</p>
                        <br/>
                        <hr/>
                        <br/>
                        <h3 class="text-center">Objectifs réalisés</h3>
                        <p>Cette présente édition est une visualisation HTML de l'encodage TEI initial. Cette transformation a été réalisée à l'aide d'XSLT 2.0.</p>
                        <h5>Modifications de l'encodage initial :</h5>
                        <p>Quelques changements minimes de l'encodage TEI ont été effectués pour la propreté de la visualisation, et pour répondre aux besoins des objectifs de la transformation :</p>
                        <ul>
                            <li>oublis de balises ajoutés,</li>
                            <li>corrections des erreurs dans le nom de balises,</li>
                            <li>suppression des séparations au sein d'un nom de personnage et au sein d'un nom de lieu causés par les sauts de lignes.</li>
                        </ul>
                        <p>Ces changements ne vont pas à l'encontre des règles de transcription établies (cf. 1.1.2 de l'ODD).</p> 
                        <br/>
                        <h5>Objectifs de la transformation :</h5>
                        <p>La transformation de l'encodage TEI s'attache à mettre en oeuvre une partie des objectifs exposés dans l'ODD.</p>
                        <p>Concernant la <b>représentation fidèle de la mise en page pour l'étude typographique de la source</b> : </p>
                        <ul>
                            <li>Nous avons reproduit l'ensemble des éléments typographiques de la source (changements de pages, sauts de lignes, placement du texte, italique, etc.) à l'exception des colonnes.</li>
                        </ul>
                        
                        <p>Concernant la <b>reproduction littérale du contenu du texte pour l'étude de la langue</b> :</p>
                        <ul>
                            <li>Comme évoqué dans l'ODD, nous avons reproduit le texte de la source tel quel.</li>
                        </ul>
                        
                        <p>Concernant la <b>mise en avant des personnages et des lieux de l'œuvre pour l'étude littéraire</b> :</p>
                        <ul>
                            <li>Nous avons produit une transcription enrichie afin de permettre à l'utilisateur d'accéder à des informations supplémentaires sur les personnages et les lieux mentionnés en cliquant sur les liens de ces derniers.</li>
                            <li>Nous avons mis en place deux index afin de recenser l'ensemble des personnages et des lieux mentionnés dans l'extrait. Ces derniers sont classés selon divers regroupements.</li>
                            <li>Nous avons créé des fiches descriptives où figure le nom de l'entité, son type, le chapitre dans lequel elle apparaît, sa contextualisation, ainsi que ses descriptions et ses qualifications mentionnées dans le texte.</li>
                            <li>Nous avons mis en valeur les relations entre les personnages en indiquant le type de relation et les personnages concernés.</li>
                        </ul>
                        <br/>
                        <h5>Réutilisations de l'encodage TEI et de la feuille XSL :</h5>
                        <p>La feuille XSL a été majoritairement pensée pour être appliquée sur l'encodage TEI de l'épisode en question, mais aussi sur l'encodage potentiel des autres épisodes de l'oeuvre. En effet, l'ensemble des 
                            épisodes du roman-feuilleton sont publiés de manière identique à chaque numéro. Cet encodage TEI pourrait donc s'appliquer sur les autres épisodes et cette même feuille XSL fonctionnerait par là même.</p>
                        <p>Nous pourrions réemployer l'encodage TEI ainsi que la feuille XSL pour d'autres projets d'édition numérique de romans-feuilletons du journal <i>La Presse</i>. Bien que les choix appliqués aient 
                            été pensés par rapport aux caractéristiques propres à l'épisode traité, la publication des romans-feuilletons est très ressemblante d'un roman-feuilleton à l'autre.</p>
                    </div>
                    <br/>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- Sortie HTML de la page consignes -->
        <xsl:result-document href="{$chemin_consignes}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container">
                        <h1 class="text-center">Consignes</h1>
                        <br/>
                        <h3>Étape 1 : consignes de l'évaluation TEI</h3>
                        <ul>
                            <li>Structurer en XML-TEI votre texte en vue d’une édition et en respectant le genre auquel appartient votre extrait (/6) ;</li>
                            <li>Compléter de la manière la plus précise possible le teiHeader de votre édition, en fonction des éléments nécessaires à son établissement et à la compréhension du texte (/4) ;</li>
                            <li>Écrire une ODD adaptée à votre encodage et documentée (/10).</li>
                        </ul>
                        <br/>
                        <h3>Étape 2 : consignes de l'évaluation XSLT</h3>
                        <ul>
                            <li>Mettre en place une structure d’accueil LaTeX ou HTML (/5) ;</li>
                            <li>Rédiger des règles simples avec un Xpath valide pour insérer des informations du document source dans le document de sortie (/4) ;</li>
                            <li>Créer une ou des règles avec des conditions (/4) ;</li>
                            <li>Utiliser une ou des règles avec for-each uniquement si cela est nécessaire (/3) ;</li>
                            <li>Proposer un code facile à lire et commenté (/2) ;</li>
                            <li>Simplifier le plus possible ses règles XSL (/2).</li>
                        </ul>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
        
        
        <!-- RUBRIQUE 'Types de transcription' -->
        
        <!-- Sortie HTML de la page transcription brute -->
        <xsl:result-document href="{$chemin_transcription}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container">
                        <xsl:element name="div">
                            <!-- Appel du body sur lequel plusieurs règles XSL s'appliquent, elles sont détaillées dans la suite du document -->
                            <xsl:apply-templates select="//body"/>
                        </xsl:element>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- Sortie HTML de la page transcription enrichie -->
        <xsl:result-document href="{$chemin_transcription_enrichie}"  method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container">
                        <xsl:element name="div">
                            <!-- Appel du body sur lequel plusieurs règles XSL s'appliquent, les règles sont celles rattachées au mode spécifique 'enrichi' ainsi qu'au mode 'all' -->
                            <xsl:apply-templates select="//body" mode="enrichi"/>
                        </xsl:element>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
        
        
        <!-- RUBRIQUE 'Index' -->
        
        <!-- Sortie HTML de la page index des personnages -->
        <xsl:result-document href="{$chemin_pers_index}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container">
                        <h1 class="text-center">Index des personnages</h1>
                        <br/>
                        <ul>
                            <!-- L'attribut @name contient le template 'pers_index', xsl:call-template nous permet de récupérer les règles de ce template défini plus bas -->
                            <xsl:call-template name="pers_index"/>
                        </ul>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- Sortie HTML de la page index des lieux -->
        <xsl:result-document href="{$chemin_place_index}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container">
                        <h1 class="text-center">Index des lieux</h1>
                        <br/>
                        <ul>
                            <!-- L'attribut @name contient le template 'place_index', xsl:call-template nous permet de récupérer les règles de ce template défini plus bas -->
                            <xsl:call-template name="place_index"/>
                        </ul>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
        
        
        <!-- RUBRIQUE 'Analyses contextuelles' -->
        
        <!-- Sortie HTML de la page relations entre les personnages -->
        <xsl:result-document href="{$chemin_relations_perso}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container">
                        <h1 class="text-center">Relations entre les personnages</h1>
                        <br/>
                        <!-- L'attribut @name contient le template 'relations_perso', xsl:call-template nous permet de récupérer les règles de ce template défini plus bas -->
                        <xsl:call-template name="relations_perso"/>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- Sortie HTML de la page fiche descriptive des personnages -->
        <xsl:result-document href="{$chemin_fiche_perso}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container">
                        <h1 class="text-center">Fiche descriptive des personnages</h1>
                        <br/>
                        <ul>
                            <!-- L'attribut @name contient le template 'fiche_perso', xsl:call-template nous permet de récupérer les règles de ce template défini plus bas -->
                            <xsl:call-template name="fiche_perso"/>
                        </ul>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- Sortie HTML de la page fiche descriptive des lieux -->
        <xsl:result-document href="{$chemin_fiche_lieu}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container">
                        <h1 class="text-center">Fiche descriptive des lieux</h1>
                        <br/>
                        <ul>
                            <!-- L'attribut @name contient le template 'fiche_lieu', xsl:call-template nous permet de récupérer les règles de ce template défini plus bas -->
                            <xsl:call-template name="fiche_lieu"/>
                        </ul>
                    </div>
                </body>
                <xsl:copy-of select="$footer"/>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    
    
    
    <!-- ENSEMBLE DES RÈGLES -->
    
    <!-- RÈGLES pour l'affichage des transcriptions -->
    <!-- Le mode 'enrichi' permet d'appliquer les règles propres à la transcription enrichie -->
    <!-- Le mode 'all' permet d'appliquer les règles sur la transcription et la transcription enrichie -->
    
    <!-- Gestion typographique des en-têtes des divisions -->    
    <xsl:template match="//body//div[@type='paper']/head" mode="#all">
        <xsl:element name="h4">
            <xsl:attribute name="class">text-center text-uppercase</xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>   
    
    <xsl:template match="//body//div[@type='serial_novel']/head" mode="#all">
        <xsl:element name="h1">
            <xsl:attribute name="class">text-center text-uppercase</xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
        <br/>
    </xsl:template>   
    
    <xsl:template match="//body//div[@type='chapter']/head" mode="#all">
        <xsl:element name="p">
            <xsl:attribute name="class">text-center</xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <!-- Gestion typographique des mentions de date -->
    <xsl:template match="//body/div[@type='paper']/dateline" mode="#all">
        <xsl:element name="h6">
            <xsl:attribute name="class">text-center text-uppercase</xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
        <br/>
    </xsl:template>
    
    <xsl:template match="//body//div[@type='chapter']/dateline" mode="#all">
        <xsl:element name="p">
            <xsl:attribute name="class">text-end</xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <!-- Gestion typographique de la signature -->
    <xsl:template match="//body//fw[@type='sig']" mode="#all">
        <xsl:element name="p">
            <xsl:attribute name="class">text-end text-uppercase</xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <!-- Gestion des changements de pages -->
    <xsl:template match="//body//pb" mode="#all">       
        <xsl:element name="hr">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>

    <!-- Gestion des paragraphes -->
    <xsl:template match="//body//p" mode="#all">
        <xsl:element name="p">
            <xsl:apply-templates mode="#current"/>
        </xsl:element>
    </xsl:template>

    <!-- Gestion des passages à la ligne -->
    <xsl:template match="//body//lb" mode="#all">
        <xsl:element name="br"/>
    </xsl:template>
    
    <!-- Gestion des italiques -->
    <xsl:template match="//*[contains(@rend, 'italic')]">
        <xsl:element name="i">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <!-- Gestion de la transcription enrichie -->
    <xsl:template match="//body//persName" mode="enrichi">
        <!-- On recrée les variables des chemins de fichier car celles créées initialement ne peuvent pas s'appliquer directement ici -->
        <xsl:variable name="witfile">
            <xsl:value-of select="replace(base-uri(.), 'TEI_LaDaniella_FL.xml', '')"/>
        </xsl:variable>
        <xsl:variable name="chemin_pers_index">
            <xsl:value-of select="concat($witfile, 'html/pers_index', '.html')"/>
        </xsl:variable>
        <!-- On balise le texte des éléments <persName> à l'aide de la balise <a> permettant de renvoyer à l'index des noms de personnages -->
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="$chemin_pers_index"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="//body//placeName" mode="enrichi">
        <!-- On recrée les variables des chemins de fichier car celles créées initialement ne peuvent pas s'appliquer directement ici -->
        <xsl:variable name="witfile">
            <xsl:value-of select="replace(base-uri(.), 'TEI_LaDaniella_FL.xml', '')"/>
        </xsl:variable>
        <xsl:variable name="chemin_place_index">
            <xsl:value-of select="concat($witfile, 'html/place_index', '.html')"/>
        </xsl:variable>
        <!-- On balise le texte des éléments <placeName> à l'aide de la balise <a> permettant de renvoyer à l'index des noms de lieux -->
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="$chemin_place_index"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
   
   
    <!-- RÈGLES pour l'affichage de l'index des personnages et personnes -->
    <xsl:template name="pers_index">
        
        <!-- Liste des personnages principaux -->
        <h3 class="text-center">Personnages principaux</h3>
        
        <!-- Mise en place d'une condition : si l'extrait contient une liste ayant un attribut @type de valeur 'main_characters', alors la règle est appliquée, sinon il est 
        précisé qu'il n'y a pas de personnages principaux dans l'extrait encodé -->
        <xsl:choose>
            <xsl:when test="//listPerson[@type='main_characters']/person">
                <p class="text-center">L'extrait contient <b><xsl:value-of select="count(//listPerson[@type='main_characters']/person)"/></b> personnages principaux.</p>
                <!-- Boucle permettant d'afficher la liste des personnages principaux -->
                <xsl:for-each select="//listPerson[@type='main_characters']/person">
                    <!-- Classement alphabétique de la liste obtenue -->
                    <xsl:sort select="persName" order="ascending"/>
                    <li>
                        <!-- On affiche le nom du personnage -->
                        <a class="text-bold" href="{$chemin_fiche_perso}"><xsl:value-of select="persName"/></a>
                        <br/>   
                    </li>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <p>L'extrait ne contient pas de personnages principaux.</p>
            </xsl:otherwise>
        </xsl:choose>
        
        <!-- Les règles ci-dessous sont construites de la même façon -->        
        
        <!-- Liste des personnages secondaires classés en deux sous-ensembles -->
        <h3 class='text-center'>Personnages secondaires</h3>
        
        <!-- Liste des personnages secondaires -->
        <xsl:choose>
            <xsl:when test="//listPerson[@type='secondaries_characters']/person">
                <h6 class='text-center'>Personnage(s) secondaire(s)</h6>
                <p class="text-center">L'extrait contient <b><xsl:value-of select="count(//listPerson[@type='secondaries_characters']/person)"/></b> personnage(s) secondaire(s).</p>
                <xsl:for-each select="//listPerson[@type='secondaries_characters']/person">
                    <xsl:sort select="persName" order="ascending"/>
                    <li>
                        <a class="text-bold" href="{$chemin_fiche_perso}"><xsl:value-of select="persName"/></a>
                        <br/>
                    </li>
                </xsl:for-each>
                <br/>
            </xsl:when>
            <xsl:otherwise>
                <p>L'extrait ne contient pas de personnages secondaires.</p>
            </xsl:otherwise>
        </xsl:choose>
        
        <!-- Liste des groupes de personnages secondaires -->
        <xsl:choose>
            <xsl:when test="//listPerson[@type='secondaries_characters']/personGrp">
                <h6 class='text-center'>Groupe(s) de personnage(s) secondaire(s)</h6>
                <p class="text-center">L'extrait contient <b><xsl:value-of select="count(//listPerson[@type='secondaries_characters']/personGrp)"/></b> groupe(s) de personnage(s) secondaire(s).</p>
                <xsl:for-each select="//listPerson[@type='secondaries_characters']/personGrp">
                    <xsl:sort select="@xml:id" order="ascending"/>
                    <li>
                        <!-- Les groupes de personnages n'ont pas de persName, nous utilisons donc leur identifiant comme dénomination, pour cela nous utilisons la fonction 'translate' afin de 
                            remplacer les signes '#' et "_" par une espace -->
                        <a class="text-bold" href="{$chemin_fiche_perso}"><xsl:value-of select="./translate(@xml:id, '#_', '  ')"/></a>
                        <br/>
                    </li>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <p>L'extrait ne contient pas de groupes de personnages secondaires.</p>
            </xsl:otherwise>
        </xsl:choose>
        
        
        <!-- Liste des autres personnages et personnes cités classés en deux sous-ensembles -->
        <h3 class="text-center">Autres</h3>
        
        <!--Liste autres personnages cités -->
        <xsl:choose>
            <xsl:when test="//listPerson[@type='other_characters_mentioned']/person">
                <h6 class='text-center'>Autre(s) personnage(s) cité(s)</h6>
                <p class="text-center">L'extrait contient <b><xsl:value-of select="count(//listPerson[@type='other_characters_mentioned']/person)"/></b> autre(s) personnage(s) cité(s).</p>
                <xsl:for-each select="//listPerson[@type='other_characters_mentioned']/person">
                    <xsl:sort select="persName" order="ascending"/>
                    <li>
                        <a class="text-bold" href="{$chemin_fiche_perso}"><xsl:value-of select="persName"/></a>
                        <br/>
                    </li>
                </xsl:for-each>
                <br/>
            </xsl:when>
            <xsl:otherwise>
                <p>L'extrait ne contient pas de personnages autre.</p>
            </xsl:otherwise>
        </xsl:choose>
        
        <!-- Liste artistes cités -->
        <xsl:choose>
            <xsl:when test="//listPerson[@type='painters']/person">
                <h6 class='text-center'>Artiste(s) cité(s)</h6>
                <p class="text-center">L'extrait contient <b><xsl:value-of select="count(//listPerson[@type='painters']/person)"/></b> artiste(s) cité(s).</p>
                <xsl:for-each select="//listPerson[@type='painters']/person">
                    <xsl:sort select="persName" order="ascending"/>
                    <li>
                        <a class="text-bold" href="{$chemin_fiche_perso}"><xsl:value-of select="persName"/></a>
                        <br/>
                    </li>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <p>L'extrait ne contient pas d'artistes.</p>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>

    
    <!-- RÈGLES pour afficher l'index des lieux -->
    <xsl:template name="place_index" match="//settingDesc//listPlace">
        
        <!-- Liste des lieux visités -->
        <h3 class='text-center'>Lieux mentionnés et visités</h3>
        <xsl:choose>
            <xsl:when test="//settingDesc/listPlace[@type='places_visited']/place">
                <p class="text-center">L'extrait contient <b><xsl:value-of select="count(//settingDesc/listPlace[@type='places_visited']/place)"/></b> lieu(x) mentionné(s) et visité(s).</p>
                <xsl:for-each select="//settingDesc/listPlace[@type='places_visited']/place">
                    <!-- Les noms des lieux sont contenus soit dans la balise placeName, soit dans la balise geogName -->
                    <xsl:sort select="placeName, geogName" order="ascending"/>  
                    <li>
                        <a class="text-bold" href="{$chemin_fiche_lieu}"><xsl:value-of select="placeName, geogName"/></a>
                        <br/>
                    </li>
                </xsl:for-each>
                <br/>
            </xsl:when>
            <xsl:otherwise>
                <p>L'extrait ne contient pas de lieux visités.</p>
            </xsl:otherwise>
        </xsl:choose>
        
        <!-- Liste des lieux non visités -->
        <h3 class='text-center'>Lieux mentionnés mais non visités</h3>
        <xsl:choose>
            <xsl:when test="//listPlace[@type='places_mentioned']/place">
                <p class="text-center">L'extrait contient <b><xsl:value-of select="count(//listPlace[@type='places_mentioned']/place)"/></b> lieu(x) mentionné(s) mais non visité(s).</p>
                <xsl:for-each select="//listPlace[@type='places_mentioned']/place">
                    <!-- Les noms des lieux sont contenus soit dans la balise placeName, soit dans la balise geogName -->
                    <xsl:sort select="placeName, geogName" order="ascending"/>
                    <li>
                        <a class="text-bold" href="{$chemin_fiche_lieu}"><xsl:value-of select="placeName, geogName"/></a>
                        <br/>
                    </li>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <p>L'extrait ne contient pas de lieux non visités.</p>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>


    <!-- RÈGLES pour afficher les relations entre les personnages -->
    <xsl:template name="relations_perso">
        <div class="text-center">
            <p>Il y a <b><xsl:value-of select="count(//standOff/listRelation/@type)"/></b> groupes de relation mis en avant dans l'extrait édité : <b><xsl:value-of select="//standOff/listRelation/@type"/></b>.</p>
            <p>L'analyse met en avant des <b>relations mutuelles</b> (personnages pour lesquels la relation est réciproque) et des <b>relations non mutuelles</b> (relation à sens unique entre un personnage actif et un personnage passif).</p>
            <p>Voici ci-dessous le détail de ces dernières.</p>
            <br/>
        </div>
        <!-- L'élément 'standOff' contient plusieurs 'listRelation', on boucle sur ces derniers -->
        <xsl:for-each select="//standOff/listRelation">
            <!-- Titres de niveau 2 correspondent aux valeurs de l'attribut @type et ils sont mis en majuscule grâce à la fonction 'upper-case' -->
            <h2 class="text-center">
                <xsl:value-of select="upper-case(./@type)"/>
            </h2>
            
            <!-- L'élement 'listRelation' peut contenir plusieurs éléments 'relation', on boucle alors sur ces derniers -->
            <xsl:for-each select="./relation">
                <br/>
                <ul>
                    <li>
                        <dl>
                            <dt>Personnages :</dt>
                            <xsl:choose>
                                <!-- Condition permettant d'appliquer la règle si l'élément 'relation' a un attribut @active (s'il y a la présence de cet attribut, cela sous-entend aussi la présence de l'attribut @passive) -->
                                <xsl:when test="./@active">
                                    <!-- On affiche les valeurs des attributs @active et @passive et on les nettoie à l'aide de la fonction 'translate()' (remplacer les caractères # et _ par une espace) -->
                                    <dd>
                                        <xsl:value-of select="./translate(@active, '#_', '  ')"/> (actif) 
                                        &#8594;
                                        <xsl:value-of select="./translate(@passive, '#_', '  ')"/> (passif)
                                    </dd>
                                </xsl:when>
                                
                                <!-- Autre règle appliquée si l'élément 'relation' ne possède pas d'attribut @active, (traitement de l'attribut @mutual par déduction) -->
                                <xsl:otherwise>
                                    <!-- On affiche les valeurs de l'attribut @mutual et on les nettoie à l'aide de la fonction 'translate()' (remplacer les caractères # et _ par un espace) -->
                                    <dd>
                                        <xsl:value-of select="./translate(@mutual, '#_', '  ')"/> (mutuel)
                                    </dd>
                                </xsl:otherwise>
                            </xsl:choose>
                            
                            <dt>Type de relation :</dt>
                            <dd>
                                <!-- On affiche la valeur de l'attribut @name -->
                                <xsl:value-of select="./@name"/>
                            </dd>
                        </dl>
                    </li>
                </ul>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    
    
    <!-- RÈGLES pour afficher les fiches descriptives -->
    
    <!-- RÈGLES insérées par la suite dans les templates des fiches descriptives des personnages et des lieux -->
    
    <!--Règle permettant d'afficher le contenu de l'élément 'note' des personnages et des lieux, cette règle est insérée dans les templates 'fiche_perso' et 'fiche_lieu' à l'aide de 'call-template'-->
    <xsl:template name="contextualisation">
        
        <!-- On crée une condition permettant d'afficher le contenu de l'élément 'note' si ce dernier est présent, si ce n'est pas le cas, l'information contextualisation n'apparaît pas -->
        <xsl:choose>
            <xsl:when test="note">
                <dd><b>Contextualisation : </b><xsl:value-of select="note"/></dd>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
        
    </xsl:template>

    <!-- Règle permettant d'afficher le chapitre dans lequel est mentionné le personnage, cette règle est insérée dans le template 'fiche_perso' à l'aide de 'call-template' -->
    <xsl:template name="mention_chapitre_perso">
        
        <!-- On crée une variable pour stocker l'attribut @xml:id du personnage -->
        <xsl:variable name="person_id">
            <xsl:value-of select="./@xml:id"/>
        </xsl:variable>
        
        <dd>
            <!-- Condition permettant d'afficher le chapitre dans lequel apparaît le personnage en question, certains personnages n'étant mentionnés que dans des 'rs', c'est pour cela que nous créeons 
                        une condition afin d'appliquer la règle à la fois sur les 'persName' et sur les 'rs' -->
            <xsl:choose>
                <xsl:when test="ancestor::TEI//body/div//persName[@ref = concat('#', $person_id)]">
                    <b>Mention : </b>
                    <!-- On itère sur les 'persName'et on les grou-->
                    <xsl:for-each-group select="ancestor::TEI//body/div//persName[@ref = concat('#', $person_id)]" group-by="ancestor::div[1]">
                        <xsl:value-of select="concat(ancestor::div[1]/@type, ' ', ancestor::div[1]/@n, '  ')"/>
                    </xsl:for-each-group>
                    <br/>
                </xsl:when>
            
                <xsl:otherwise>
                    <b>Mention : </b>
                    <xsl:for-each-group select="ancestor::TEI//body/div//rs[@ref = concat('#', $person_id)]" group-by="ancestor::div[1]">
                        <xsl:value-of select="concat(ancestor::div[1]/@type, ' ', ancestor::div[1]/@n, '  ')"/>
                    </xsl:for-each-group>
                </xsl:otherwise>
            </xsl:choose>
        </dd>
        
    </xsl:template>
    
    <!-- Règle permettant d'afficher le chapitre dans lequel est mentionné le lieu, cette règle est insérée dans le template 'fiche_lieu' à l'aide de 'call-template' -->
    <xsl:template name="mention_chapitre_lieu">
        
        <xsl:variable name="place_id">
            <xsl:value-of select="./@xml:id"/>
        </xsl:variable>
        
        <dd> 
            <xsl:choose>
                <xsl:when test="ancestor::TEI//body/div//placeName[@ref = concat('#', $place_id)]">
                    <b>Mention : </b>
                    <xsl:for-each-group select="ancestor::TEI//body/div//placeName[@ref = concat('#', $place_id)]" group-by="ancestor::div[1]">
                        <xsl:value-of select="concat(ancestor::div[1]/@type, ' ', ancestor::div[1]/@n, '  ')"/>
                    </xsl:for-each-group>
                    <br/>
                </xsl:when>
                
                <xsl:otherwise>
                    <xsl:for-each-group select="ancestor::TEI//body/div//rs[@ref = concat('#', $place_id)]" group-by="ancestor::div[1]">
                        <b>Mention : </b> <xsl:value-of select="concat(ancestor::div[1]/@type, ' ', ancestor::div[1]/@n, '  ')"/>
                    </xsl:for-each-group>
                    <br/>
                </xsl:otherwise>
            </xsl:choose>
        </dd>
        <br/>
        
    </xsl:template>
    
    <!-- Règle permettant d'afficher les diverses descriptions et qualifications des personnages, cette règle est insérée dans le template 'fiche_perso' à l'aide de 'call-template'-->
    <xsl:template name="desc_perso">
        
        <xsl:variable name="person_id">
            <xsl:value-of select="./@xml:id"/>
        </xsl:variable>
        
        <dd>
            <b>Description(s) personnalité(s) :</b>
            <xsl:for-each select="//rs[@ref = concat('#', $person_id)]">
                <xsl:if test="./@subtype='personality'">
                    <ul><li><xsl:value-of select="."/></li></ul>
                </xsl:if>
            </xsl:for-each>
        </dd>
    
        <dd>
            <b>Description(s) physique(s) :</b>
            <xsl:for-each select="//rs[@ref = concat('#', $person_id)]">
                <xsl:if test="./@subtype='physical'">
                    <ul><li><xsl:value-of select="."/></li></ul>
                </xsl:if>
            </xsl:for-each>
        </dd>
    
        <dd>
            <b>Description(s) mixte(s) :</b>
            <xsl:for-each select="//rs[@ref = concat('#', $person_id)]">
                <xsl:if test="./@subtype='physical_personality'">
                    <ul><li><xsl:value-of select="."/></li></ul>
                </xsl:if>
            </xsl:for-each>
        </dd>
    
        <dd>
            <b>Qualification(s) :</b>
            <xsl:for-each select="//rs[@ref = concat('#', $person_id)]">
                <xsl:if test="./@type='person'">
                    <ul><li><xsl:value-of select="."/></li></ul>
                </xsl:if>
            </xsl:for-each>
        </dd>
        <br/>
        
    </xsl:template>
    
    <!-- Règle permettant d'afficher les diverses descriptions et qualifications des lieux, cette règle est insérée dans le template 'fiche_perso' à l'aide de 'call-template'-->
    <xsl:template name="desc_lieu">
        
        <xsl:variable name="place_id">
            <xsl:value-of select="./@xml:id"/>
        </xsl:variable>
        
        <dd>
            <b>Description(s) : </b>
            <xsl:for-each select="//rs[@ref = concat('#', $place_id)]">
                <xsl:if test="./@subtype='physical'">
                    <ul><li><xsl:value-of select="."/></li></ul>
                </xsl:if>
            </xsl:for-each>
        </dd>
        
        <dd>
            <b>Qualification(s) :</b>
            <xsl:for-each select="//rs[@ref = concat('#', $place_id)]">
                <xsl:if test="./@type='place'">
                    <ul><li><xsl:value-of select="."/></li></ul>
                </xsl:if>
            </xsl:for-each>
        </dd>
        <br/>
    </xsl:template>

    <!-- RÈGLES permettant l'affichage de la fiche descriptive des personnages -->
    <xsl:template name="fiche_perso">
        
        <!-- Liste descriptive des personnages principaux -->
        <h3 class="text-center">Personnages principaux</h3>
        <xsl:for-each select="//listPerson[@type='main_characters']/person">            
            <xsl:sort select="persName" order="ascending"/>              
            <li>
                <dl>
                    <!-- On affiche le nom du personnage contenu dans l'élément 'persName' -->
                    <dt><h4><xsl:value-of select="persName"/></h4></dt>
                    <!-- On affiche le sexe du personnage contenu dans l'attribut @sex -->
                    <dd><b>Genre : </b> <xsl:value-of select="@sex"/></dd>
                    <!-- On appelle le template 'contextualisation' pour afficher la 'note' -->
                    <xsl:call-template name="contextualisation"/>
                    <!-- On appelle le template 'mention_chapitre_perso' pour afficher le chapitre dans lequel est mentionné le personnage -->
                    <xsl:call-template name="mention_chapitre_perso"/>
                    <!-- On appelle le template 'desc_perso' pour afficher les diverses descriptions et qualifications du personnage -->
                    <xsl:call-template name="desc_perso"/>
                    <br/>  
                </dl>                
            </li>         
        </xsl:for-each>
 
        <!-- Liste descriptive des personnages secondaires classés en deux sous-ensembles -->
        <h3 class='text-center'>Personnages secondaires</h3>
        <h6 class='text-center'>Personnage(s) secondaire(s)</h6>
        <xsl:for-each select="//listPerson[@type='secondaries_characters']/person">            
            <xsl:sort select="persName" order="ascending"/>              
            <li>
                <dl>
                    <dt><h4><xsl:value-of select="persName"/></h4></dt>
                    <dd><b>Genre : </b> <xsl:value-of select="@sex"/></dd>      
                    <xsl:call-template name="contextualisation"/>
                    <xsl:call-template name="mention_chapitre_perso"/>
                    <xsl:call-template name="desc_perso"/>        
                </dl>                
            </li>         
        </xsl:for-each>
        
        
        <h6 class='text-center'>Groupe(s) de personnage(s) secondaire(s)</h6>
        <xsl:for-each select="//listPerson[@type='secondaries_characters']/personGrp">            
            <xsl:sort select="@xml:id" order="ascending"/>              
            <li>
                <dl>
                    <dt><h4><xsl:value-of select="./translate(@xml:id, '#_', '  ')"/></h4></dt>
                    <dd><b>Genre : </b> <xsl:value-of select="@sex"/></dd> 
                    <xsl:call-template name="contextualisation"/>                    
                    <xsl:call-template name="mention_chapitre_perso"/>
                    <xsl:call-template name="desc_perso"/>          
                </dl>                
            </li>         
        </xsl:for-each>
        
    
        <!--Liste descriptives des autres personnages et personnes cités -->
        <h3 class="text-center">Autres</h3>
        <h6 class='text-center'>Autre(s) personnage(s) cité(s)</h6>
        <xsl:for-each select="//listPerson[@type='other_characters_mentioned']/person">            
            <xsl:sort select="persName" order="ascending"/>              
            <li>
                <dl>
                    <dt><h4><xsl:value-of select="persName"/></h4></dt>
                    <dd><b>Genre : </b> <xsl:value-of select="@sex"/></dd>      
                    <xsl:call-template name="contextualisation"/>
                    <xsl:call-template name="mention_chapitre_perso"/>          
                </dl>    
            </li>         
        </xsl:for-each>
        
        <h6 class='text-center'>Artiste(s) cité(s)</h6>
        <xsl:for-each select="//listPerson[@type='painters']/person">            
            <xsl:sort select="persName" order="ascending"/>              
            <li>
                <dl>
                    <dt><h4><xsl:value-of select="persName"/></h4></dt>
                    <dd><b>Genre : </b> <xsl:value-of select="@sex"/></dd>      
                    <xsl:call-template name="contextualisation"/>
                    <xsl:call-template name="mention_chapitre_perso"/>
                </dl>                
            </li>         
        </xsl:for-each>

    </xsl:template>
    

    <!-- RÈGLES pour afficher la fiche descriptive des lieux -->
    <xsl:template name="fiche_lieu">
        
        <!-- Liste des lieux visités -->
        <h3 class='text-center'>Lieux mentionnés et visités</h3>
        <xsl:for-each select="//settingDesc/listPlace[@type='places_visited']/place">
            <!-- Les noms des lieux sont contenus soit dans la balise placeName, soit dans la balise geogName -->
            <xsl:sort select="placeName, geogName" order="ascending"/>              
            <li>
                <dl>
                    <dt><h4><xsl:value-of select="placeName, geogName"/></h4></dt>
                    <dd><b>Type : </b> <xsl:value-of select="@type"/></dd>  
                    
                    <xsl:choose>
                        <xsl:when test="location/country, location/region, location/settlement">
                            <dd><b>Localisation : </b><xsl:value-of select="concat(location/country/@key, '  ', location/region, '  ', location/settlement)"/></dd>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                   
                   <xsl:call-template name="contextualisation"/>
                    <xsl:call-template name="mention_chapitre_lieu"/>
            <xsl:call-template name="desc_lieu"/>
                </dl>                
            </li>         
        </xsl:for-each>
        <br/>
        
        <!-- Liste des lieux non visités -->
        <h3 class='text-center'>Lieux mentionnés mais non visités</h3>
        <xsl:for-each select="//listPlace[@type='places_mentioned']/place">
            <!-- Les noms des lieux sont contenus soit dans la balise placeName, soit dans la balise geogName -->
            <xsl:sort select="placeName, geogName" order="ascending"/>              
            <li>
                <dl>
                    <dt><h4><xsl:value-of select="placeName, geogName"/></h4></dt>
                    <dd><b>Type : </b> <xsl:value-of select="@type"/></dd>  
                    
                    <xsl:choose>
                        <xsl:when test="location/country, location/region, location/settlement">
                            <dd><b>Localisation : </b><xsl:value-of select="concat(location/country/@key, '  ', location/region, '  ', location/settlement)"/></dd>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                    
                    <xsl:call-template name="contextualisation"/>
                    <xsl:call-template name="mention_chapitre_lieu"></xsl:call-template>
                    <xsl:call-template name="desc_lieu"/>
                </dl>                
            </li>         
        </xsl:for-each>
        <br/>
        
    </xsl:template>

    
</xsl:stylesheet>