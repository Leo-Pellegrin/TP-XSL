<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="iso-8859-1" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head> 
                <link rel="stylesheet" type="text/css" href="film.css"/>
                <title> cinmatographie </title> 
                <script src ="https://code.jquery.com/jquery-2.2.4.min.js" > </script>
                <script src="scroll.js"> </script>
                <link rel="stylesheet" type="text/css" href="scroll.css" />
            </head>
            <body>
                <div id="main">
                    <section>
                        <h1>Table des matières des films</h1>
                        <xsl:apply-templates select="films/film" mode="tdm">
                            <xsl:sort select="@anneesortie" order="descending" data-type="number"/>
                        </xsl:apply-templates>
                    </section>
                    <section>
                        <h1>Table des matières des acteurs</h1>
                        <xsl:apply-templates select="films/acteurDescription"/>
                    </section>
                    <xsl:apply-templates select="films/film" mode="complet">
                        <xsl:sort select="@anneesortie" order="descending" data-type="number"/>
                    </xsl:apply-templates>
                </div>

                <script>
                    $("#main").onepage_scroll({
                        sectionContainer: "section",
                        easing: "ease",
                        animationTime: 1000,
                        pagination: true,
                        updateURL: false,
                        beforeMove: function(index) {},
                        afterMove: function(index) {},
                        loop: false,
                        keyboard: true,
                        responsiveFallback: false
                        });
                    function tdm(id){
                        $(".main").moveTo(id + 2);
                    }
                </script>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="film" mode="tdm">
        <ul>
            <a>
                <xsl:attribute name="onclick">tdm(<xsl:value-of select="position()"/>)</xsl:attribute>                       
                <xsl:value-of select="titre"/> <i> ( <xsl:value-of select="count(acteurs/acteur)"/> acteurs )</i>
                [ <xsl:value-of select="scenario/keyword"/> ]
            </a>
        </ul>
    </xsl:template>

    <xsl:template match="film" mode="complet">
        <section>
            <xsl:if test="@anneesortie = '2023'">
                <h4 class="nouveaute">Nouveauté</h4>
            </xsl:if>
            <img>
                <xsl:attribute name="src">
                    <xsl:value-of select="image/@ref" />
                </xsl:attribute>
            </img>
            <a>
                <xsl:attribute name="name">
                    <xsl:value-of select="titre" />
                </xsl:attribute>
                <h2><xsl:value-of select="titre" /></h2>
            </a>
            
            <i>Film <xsl:value-of select="nationalite"/> de <xsl:value-of select="duree"/> <xsl:value-of select="duree/@unite"/> sortie en <xsl:value-of select="@anneesortie"/></i>
            <p>* Réalisé par <xsl:value-of select="realisateur"/> *</p>
            <h3>Acteurs :</h3>
            <ul>
                <xsl:for-each select="acteurs/acteur">
                    <li> <xsl:value-of select="."/> </li>
                </xsl:for-each>
            </ul>
            <p class="histoireType"> 
                <xsl:apply-templates select="scenario"/>
            </p>
            <h3>Genres :</h3>
            <ul>
                <xsl:for-each select="genres">
                    <li><xsl:value-of select="genre"/></li>
                </xsl:for-each>
            </ul>
        </section>
    </xsl:template>
    
    <xsl:template match="acteurDescription">
        <xsl:for-each select=".">
            <xsl:variable name="acteurId" select="@id"/>
            <ul>
                <xsl:value-of select="nom"/> <xsl:value-of select="prenom"/> <xsl:value-of select="dateNaissance"/> (<xsl:value-of select="count(//film/acteurs/acteur[@ref = $acteurId])"/> films)
                <xsl:for-each select="//film[acteurs/acteur[@ref = $acteurId]]">
                    <a>
                        <li>
                            <xsl:value-of select="titre"/>
                        </li>
                    </a>
                </xsl:for-each>
            </ul>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="ev">
        <i><xsl:value-of select="."/></i>
    </xsl:template>

    <xsl:template match="personnage">
        <b><xsl:value-of select="."/></b>
    </xsl:template>

</xsl:stylesheet>
