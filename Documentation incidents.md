# 🛠️ Documentation des Incidents - Projet Sportify


## 📅 Incident 1 - Erreur 500 sur la suppression d’un exercice

### 📌 Identifiant de l'incident : INC-2025-01  
### 📆 Date : 27 Février 2025  
### 👨‍💻 Auteur du rapport : @nRayen

### 🧩 Description
Lorsqu’un utilisateur tentait de supprimer un exercice, une erreur 500 était levée de manière aléatoire, sans message clair côté client.

### 🔍 Analyse
- Le backend tentait de supprimer l'exercice sans vérifier s’il était utilisé dans des séances existantes.
- Cela déclenchait une **violation de contrainte de clé étrangère** en base de données.

### ⚠️ Impact
- Expérience utilisateur cassée lors de la gestion des exercices.
- Risque d’intégrité des données si suppression forcée en base.

### ✅ Résolution
- Changement des contraintes côté base de données vers le mode **Cascade**

### 🧪 Correctif vérifié par
- Test de suppression manuelle et via requête API.

### 📌 Leçon tirée
- Toujours vérifier les relations avant suppression en base.
- Documenter les contraintes d’intégrité dans le modèle de données.

---


## 📅 Incident 2 - Mauvais format de date dans le planning des séances

### 📌 Identifiant de l'incident : INC-2025-02
### 📆 Date : 21 mars 2025
### 👨‍💻 Auteur du rapport : @nRayen

### 🧩 Description
Certains utilisateurs voyaient leurs séances planifiées apparaître à la mauvaise date ou disparaître totalement après enregistrement.

### 🔍 Analyse
- Le front envoyait les dates au format ISO (`YYYY-MM-DDTHH:mm:ssZ`), mais le backend attendait un format local (`YYYY-MM-DD`) sans l’heure.
- Lors de la sauvegarde dans la base, une conversion automatique UTC+0 créait un décalage d’un jour selon le fuseau.

### ⚠️ Impact
- Mauvaise visualisation des séances sur le calendrier.
- Planification rendue inutilisable pour les séances proches de minuit.

### ✅ Résolution
- Uniformisation du format de date/heure en UTC dans toutes les requêtes et la base.
- Parsing du fuseau horaire côté client.

### 🧪 Correctif vérifié par
- Tests manuels pour vérifier le bon fonctionnement de la planification à plusieurs heures différentes

### 📌 Leçon tirée
- Ne jamais laisser les navigateurs ou les bases interpréter les dates sans format explicite.

## 📘 Historique des incidents

| Identifiant   | Date       | Description courte                                   | Statut      |
|---------------|------------|------------------------------------------------------|-------------|
| INC-2025-01   | 27/02/2025 | Erreur 500 sur la suppression d’un exercice          | Résolu      |
| INC-2025-02   | 21/03/2025 | Mauvais format de date dans le planning des séances  | Résolu      |

