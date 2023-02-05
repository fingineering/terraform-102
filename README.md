# Terraform 102 Companion Skript

Dies ist der zweite Teil der Terraform Workshop-/ Trainingsreihe zur
Entwicklung von Infrastruktur als Code mit Terraform, mit Beispielen in anhand
der Microsoft Azure Platform. Solltest du Bedarf an einem Terraform Workshop
haben, melde dich gerne unter [Fingineering](https://finginerring.net) oder
[DATANOMIQ](https://datanomiq.de).

Diese Workshop behandelt die folgenden Themen:

1. Erstellen von Modulen um mehrere Ressourcen gleichzeitig wiederholbar zu erstellen
2. Unittesting und Integrationtesting bei der Infrastrukturentwicklung
3. Dokumentieren von Terraform Projekten

---

## Voraussetungen

- Installation eines Editors: in der Demo VS Code
- Installation einer Shell, auf der Windows Plattform: PowerShell
- Installation der Azure CLI
- Installation von Terraform und Terraform Docs
- Empfehlenswert ist es auch den ersten Teil [Terraform
  101](https://github.com/fingineering/terraform-101) erfolgreich bearbeitet zu
  haben.
- Ebenfalls ist eine grundlegende Kenntnis der Azure Cloud oder eines anderen
  Hyperscalers von Vorteil.


In diesem Workshop wird nicht weiter auf die Installation von Terraform
eingegangen bitte schaute  im [Terraform
101](https://github.com/fingineering/terraform-101) Workshop nach Informationen
dazu.

---

## Modularisierung von Ifrastruktur Code

Angenommen wir wollen immer wieder die selbe Kombinatio von Infrastruktur mit abweichenden Parametern erzeugen, 10 mal oder 100 mal. Es wäre möglich eine Terraform Datei zu erzeugen und diese immer und immer wieder zu kopieren und in jeder Datei die relevanten Parameter anzupassen. Das kann anstrengend werden und übersichtlich wird es auch nicht. Module sind hier ein Werkzeug um die Erzeugung von Infrastruktur besser zu strukturieren.

Module sind Kontainer für mehrere Resource, die immer wieder zusammen genutzt werden sollen. Im Code sind Module ein Ordner mit einer oder mehrer `.tf` Dateien. Klingt bekannt? Ganz genau, ein Terraform Projekt ist auch ein spezielles Modul, dieses wird *root Modul* genannt.

Im folgenden Beispiel wollen wir eine Datenbank und einen Storage Account erzeugen und der Identität der Datenbank auch die Möglichkeit geben direkt aus dem Storage zu lesen.

### Laden und verwenden von Modulen

Bevor wir ein eingenes Modul erzeugen, schauen wir uns an, wie ein Modul
verwendet werden kann. Um ein Modul zu verwenden, muss diese im *root Modul*
geladen werden, oder in einem Elternmodul, welches bereits von einem
Elternmodul oder dem *root Modul* geladen wurde. Es können komplexe Hierarchien
entstehen, es sollte aber beachtet werden, dass das Projekt übersichtlich
bleibt.

Module können auch aus entfernten Resourcen und Git Repositories geladen
werden, dies ermöglicht es den Aufbau eines Standard Repositories für
Infrastrukturkomponenten in einem Unternehmen.

> :warning: Benutze niemals Module aus einem öffentlichen Git Repository dem du
> nicht trauen kannst. Auch wenn du den Code gecheckt hast, forke das Module
> und nutze es nicht direkt.

Geladen wird ein Module mittels des Schlüsselworts `module`. Im Modulblock muss dann die Quelle des Moduls spezifiziert werden, sowie alle Attributed die vom Module benötigt werden. Attribute eines Modules sind die Variablen die im Modul definiert werden. Viele Editoren bieten hier auch hilfreiche Vorschläge zur Verwendung von Modulen, wenn diese ihre Variablen in einer Datei `variables.tf` deklarieren.

```hcl

// use the data twin module to create a data twin
module "datatwin" {
  source = "./data_twin"
  config = {
    data_twin_name = "my-demotwin"
    resource_group = azurerm_resource_group.my_data_twin
  }
  data_twin_admin = {
    object_id      = data.azurerm_client_config.current.object_id
    tenant_id      = data.azurerm_client_config.current.tenant_id
    user_principal = "Azure Adminitrator"
  }
}
```
