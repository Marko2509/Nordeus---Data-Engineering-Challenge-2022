U ovom dokumentu opisani su koraci u izradi projekta, načinu startovanja projekta i dobijanju rezultata.

1.) Čišćenje podataka sam radio pomoću programskog jezika python uz korišćenje biblioteke pandas.
Kako bih prikazao korake ovog procesa koristio sam jupiter notebook. 

Korake procesa i dobijene rezultate možete otvoriti pomoću browsera. Traženi fajl je Data Engineering Challenge 2022 - Nordeus.html.

Ukoliko želite da ponovo pokrećete ćelije u jupiter notebook potrebno je skinuti neki od alata za otvaranje jupiter notebook poput 
Anaconde Navigatora i otvoriti istoimeni fajl sa ekstenzijom .ipynb. Pošto se podaci čitaju iz fajlova 2. events.jsonl 
i 3. exchange_rates.jsonl njihovo ime i pozicija u folderu se u tom slučaju ne smeju menjati.

2.) Pošto se u daljim koracima dobijaju bonus poeni ako se koristi SQL iz prethodno spomenutog jupiter notebook-a sam izvezao prečišćene
rezultate za logovanje, transakcije i registraciju u vidu .csv fajlova.
U mysql workbench-u sam kreirao bazu podataka nordeus i tu kreirao tri tabele logins, transactions i registrations i uvezao podatke.

Zatim sam napisao stored procedure koje će da gađa moj rest api u cilju dobijanja podataka.

Za testiranje rest api-ja preduslov je da se kreira ista baza podataka sa istom strukturom tabela i podacima.
Zato u folderu sql možete naći skripte za kreiranje tabela, ubacivanje podataka i import stored procedura.

3.) REST api sam kreirao pomoću node.js i express-a. U izradi api korišćeni su sledeće zavisnosti:

  "dependencies": {
    "body-parser": "^1.20.1",
    "express": "^4.18.2",
    "mysql": "^2.18.1",
    "swagger-jsdoc": "^6.2.5",
    "swagger-ui-express": "^4.6.0"
  } 

express, mysql i body-parser korisćeni su za kreiranje samog REST api-ja. Dok su swagger-jsdoc i swagger-ui-express
korišćeni za pisanje interaktivne dokumentacije. 
Pretpostavljam da ce za pokretanje api-ja sa vašeg računara biti potrebna instalacija ovih modula.

Neophodno je osloboditi port 3000 ili izmeniti u fajlu api/index.js taj port i nakon 
toga u isti fajl uneti podatke za konekciju sa bazom (11. linija api/index.js):

var mysqlConnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'password',
    database: 'nordeus',
    multipleStatements: true
});

Nakon toga u terminalu se pozicionirati u folder api i izvršiti komandu: node index.js
Nakon ovog koraka u browseru otvoriti http://localhost:3000/api-docs/ i dobijate pristup dokumentaciji koju možete testirati
direktno iz browsera.

Baš mi je bilo zanimljivo i još sam naučio brojne stvari tokom izrade samog projekta, tako da autorima dajte povišicu :D
Ako zatreba bilo kakva pomoć oko pokretanja projekta, slobodno mi pišite na marko2509@gmail.com