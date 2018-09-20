# PLATFORM DEFENSE

**Platform Defense** è un videogioco basato su *open data*, il cui tema centrale sono le piattaforme che estraggono idrocarburi al largo della costa italiana. 
Il progetto permette di esplorare dinamicamente il [dataset](http://www.datiopen.it/it/opendata/Elenco_piattaforme_marine_entro_12_miglia_dalla_costa) distribuito dal [Portale Italiano dell'*Open Data*](https://www.datiopen.it) che elenca e cataloga le **piattaforme marine** entro dodici miglia dalla costa. 
Il gioco consiste nel difendere la piattaforma selezionata dall'assalto del nemico, secondo il gameplay tipico del genere *tower defense*.

### CONTESTO E OBIETTIVO DEL PROGETTO
L'attività di estrazione delle piattaforme entro dodici miglia dalla costa è un tema piuttosto controverso: tanto da essere stato oggetto di un referendum abrogativo, il 17 aprile 2016. Attraverso una rappresentazione caricaturale dei due principali fronti di opinione, Platform Defense intende avvicinare in modo imparziale il giocatore ai dati.

### GLI *OPEN DATA* UTILIZZATI
I dati sulle piattaforme sono stati raccolti dal Ministero dello Sviluppo Economico e sono aggiornati al 2016. 
Il dataset è un file JSON composto di 92 entry, una per piattaforma. Esso presenta molte informazioni, tra cui coordinate, anno di costruzione, zona, nome, tipo di struttura, distanza dalla costa, gestore, numero di pozzi e molto altro.

Il progetto attinge inoltre ai dati sul **meteo in tempo reale** forniti da [Open WeatherMap](https://openweathermap.org/current): Platform Defense riproduce infatti nell'area di gioco selezionata il meteo reale corrispondente, arricchendo la varietà del gameplay.
Per reperire questi dati vengono effettuate delle chiamate alle API di Open Weather Map tramite il protocollo HTTP, utilizzando le coordinate geografiche reperite dal dataset.

N.B. per usufruire di queste API è necessario l'utilizzo di un token, ottenibile gratuitamente registrandosi al servizio.

### GLI STRUMENTI UTILIZZATI E LA SCELTA DELL'OPEN SOURCE
Il gioco è stato sviluppato con [Godot Engine](https://godotengine.org/), mentre gli *asset* grafici sono stati realizzati con [Gimp](https://www.gimp.org/) e [Krita](https://krita.org/en/): tutti software open source.

Per il suono invece si è fatto affidamento sulla comunity di [Freesound](http://www.freesound.org).

### GESTIONE DEI DATI E DINAMICHE DEL GIOCO
Le piattaforme sono classificate in 4 aree geografiche. Prima di sviluppare il gioco è stato necessario un lavoro di *modifica* del dataset per adattarlo al gameplay finale. Ad esempio sono state eliminate le piattaforme attualmente non operative o quelle con un numero totale di pozzi troppo basso.

A quel punto è stato sviluppato il *core gameplay*: difendere la piattaforma dai nemici (delfini e pesci spada) con l'obiettivo di estrarre una determinata quantità di gas per vincere la partita. Sono stati quindi selezionati alcuni parametri per l'assegnazione di funzioni all'interno delle meccaniche di gioco. Per esempio:
- dimensioni = vita della piattaforma
- numero di pozzi di estrazione = velocità di estrazione
- posizione = area di gioco

Ciascuna piattaforma ha numero variabile di pozzi totali e di pozzi già attivi. Il giocatore può utilizzare la moneta virtuale per acquistare le torrette per difendere la piattaforma o per attivare i pozzi inattivi, velocizzando l'estrazione del gas.

Per quanto riguarda il meteo, con esso varia dinamicamente l'aspetto grafico del gioco. Cielo sereno, nuvoloso o condizioni di pioggia vengono riprodotte visivamente nel videogioco.

### COME SI GIOCA
#### REQUISITI PER IL METEO
- Un account [Open WeatherMap](https://openweathermap.org/) con un token per accedere a questa [API](https://openweathermap.org/current)
- L'inserimento manuale del proprio token nel file JSON *my_data.json*, situato nella cartella *Data*
#### CONTROLLI
- Click per interagire con gli oggetti
- Doppio click sui pozzi inattivi (cerchi grigi) per attivarli
- Drag sulla mappa per trascinare la telecamera
- Rotellina mouse per lo zoom
- ESC per chiudere il gioco
