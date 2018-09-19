# PLATFORM DEFENSE

**Platform Defense** è un videogioco basato su *open data*, il cui tema centrale sono le piattaforme che estraggono idrocarburi al largo della costa italiana. 
Il progetto permette di esplorare dinamicamente il [dataset] (link dataset) distribuito dal [Portale Italiano dell'*Open Data*] (https://www.datiopen.it) che elenca e cataloga le **piattaforme marine** entro dodici miglia dalla costa. 
Il gioco consiste nel difendere la piattaforma selezionata dall'assalto del nemico, secondo il gameplay tipico del genere *tower defense*.

### Contesto e obiettivo del progetto
L'attività di estrazione delle piattaforme entro dodici miglia dalla costa è un tema piuttosto controverso: tanto da essere stato oggetto di un referendum abrogativo, il 17 aprile 2016. Attraverso una rappresentazione caricaturale dei due principali fronti di opinione, Platform Defense intende avvicinare in modo imparziale il giocatore ai dati.

### Gli *open data* utilizzati
I dati sulle piattaforme sono stati raccolti dal Ministero dello Sviluppo Economico e sono aggiornati al 2016. 
Il dataset è un file csv composto di ... entry, una per piattaforma. ALTRE INFO TECNICHE SUL DATASET

Il progetto attinge inoltre ai dati sul **meteo in tempo reale** forniti da [Open WeatherMap] (link open weather map): Platform Defense riproduce infatti nell'area di gioco selezionata il meteo reale corrispondente, arricchendo la varietà del gameplay.
Per reperire questi dati vengono effettuate chiamate http alle API di Open Weather Map ALTRE INFO TECNICHE SULLA GESTIONE ENGINE-API

N.B. per poter attivare queste *feature* è necessario generare un token per ogni computer DFJKGHJ

### Gli strumenti: la scelta dell'open source
Il gioco è stato sviluppato con [Godot Engine] (), mentre gli *asset* grafici sono stati realizzati con [Gimp] () e [Krita] (): tutti software open source. Il codice di Platform Defense stesso è interamente accessibile su GitLab. MOTIVAZIONI DI QUESTA SCELTA

Per il suono invece si è fatto affidamento sulla comunity di [Freesound] (http://www.freesound.org).

### Gestione dei dati e dinamiche di gioco
Le piattaforme sono classificate in X aree geografiche. Per il progetto si è scelto di lavorare con i dati relativi alle aree A, B, C e D, scartando gli altri in quanto poco rilevanti (SDJVDJ). 

A quel punto è stato sviluppato il *core gameplay*: difendere la piattaforma dai nemici (delfini e pesci spada) finché l'estrazione abbia raggiunto un determinato livello. Sono stati quindi selezionati alcuni parametri per l'assegnazione di funzioni all'interno delle meccaniche di gioco. Per esempio:
-dimensioni = vita della piattaforma
-numero di pozzi di estrazione = velocità di estrazione
-posizione = area di gioco



