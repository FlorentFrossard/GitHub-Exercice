# GitHub-Exercice

~~ 🇫🇷 FRANÇAIS 🇫🇷 ~~  </br> </br>
**COMPILATION D'EXEMPLES POUR SWIFTUI** </br> </br>
Vous allez pouvoir y retrouver une mise en place de MapKit, des pulls API en provenance de Airtable, des objets d'environnement et plus encore.  </br>
Pour Airtable: vous ne pouvez pas utiliser le code tel quel car l'URL et vos données vont changer en fonction de votre base Airtable.  </br>
Ce n'est qu'un exemple de mise en pratique. </br> </br>

⚠️ **Quand vous récupérez le projet il manque un fichier: local.env** ⚠️ </br>
_(ce fichier est mit sur le .gitignore et doit contenir votre token Airtable)_  </br> </br>

**Le fichier manquant produit une erreur sur Xcode car votre pull API a besoin de ce fichier qui contient votre token API pour fonctionner.** </br> </br>
Vous devez manuellement ajouter un fichier Swift:
1. Ouvrez le projet Xcode
2. Sur le clavier: command + N  **OU BIEN** File > New File
3. Swift File
4. nommé la: local.env  </br> </br>
 
Puis à l'intérieur de ce fichier vous devez y ajouter une constante de cette manière: 
1. let apiKey = "VOTRE_TOKEN_API_AIRTABLE"
2. Vous devez mettre dans les guillemets votre token API Airtable personnel. </br> </br>

Effectuer ces actions corrige l'erreur entrainé par le fichier manquant. </br> </br> </br> </br>





##~~ 🇺🇸 ENGLISH 🇺🇸 ~~ </br> </br>
**COMPILATION OF EXAMPLES FOR SWIFTUI** </br> </br>
You can find MapKit installation, API pulls from Airtable, environment object and the like within. </br>
For Airtable: you can't use the code as it is since you must modify the URL and the data depending on your Airtable base.  </br>
This is to be used as an example. </br> </br>

⚠️ **When pulling, there is a missing file: local.env** ⚠️ </br>
_(this file was set to .gitignore and holds apiKey for Airtable)_  </br> </br>

**The missing file produce an error in Xcode because your API pull need this file containing your API token to fonction.** </br> </br>
You must manually add a Swift file: 
1. Open the project in Xcode
2. On your keyboard: command + N  **OR ELSE** File > New File
3. Swift File
4. name it: local.env </br> </br>

Then you need to add a constant as such: 
1. let apiKey = "YOUR_AIRTABLE_API_TOKEN_HERE" 
2. You must fill the quotes with your personnal Airtable API token.  </br> </br>

This will correct the error produced by the missing file.

