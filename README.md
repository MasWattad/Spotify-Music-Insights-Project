# 🎵 Spotify Music Insights Project — SQL + Power BI

This project performs a data analysis of Spotify's most streamed music using **PostgreSQL** (via **pgAdmin 4**) and visualizes the insights using **Power BI**.

## 📌 Objectives

- Analyze Spotify track metadata (e.g., danceability, energy, valence)
- Understand user engagement through likes, comments, and views
- Explore patterns across platforms like Spotify and YouTube
- Visualize insights for music trends and artist performance

---

## 🧰 Tools & Technologies

- **SQL (PostgreSQL)** via **pgAdmin 4**
- **Power BI** for data visualization
- **GitHub** for version control and sharing

---

## 🗂 Dataset Fields

The dataset includes the following fields:

| Column             | Description |
|--------------------|-------------|
| `artist`           | Name of the artist |
| `track`            | Track name |
| `album`            | Album title |
| `album_type`       | Type (album, single, compilation) |
| `danceability`     | How suitable a track is for dancing |
| `energy`, `tempo`  | Audio features from Spotify API |
| `views`, `likes`, `comments` | Engagement stats from YouTube |
| `stream`           | Spotify stream count |
| `official_video`   | Whether it's an official music video |
| `most_played_on`   | Platform with most streams (Spotify or YouTube) |

---

## 🧠 SQL Analysis Performed

The SQL queries cover:

1. **Total tracks and artists**
2. **Songs with over 1B streams**
3. **View, like, and comment statistics**
4. **Track distribution by album type**
5. **Most streamed artists and tracks**
6. **Platform analysis (Spotify vs YouTube)**
7. **Audio features (energy, danceability, valence)**
8. **Top 10% streamed track analysis**
9. **Engagement ratio per track**
10. **Feature correlations (e.g., energy vs tempo)**

SQL File: [`spotify_analysis.sql`](sql/spotify_analysis.sql)

---

## 📊 Power BI Dashboard

The Power BI dashboard presents:

- 📈 Most streamed artists and tracks
- 📊 Distribution of streams by tempo, energy, and album type
- 📌 Top 10% songs by engagement and audio features
- 🟢 Comparison of platforms (YouTube vs Spotify)
- 🔥 Insights into audience engagement (likes/views/comments)

Dashboard Screenshot:

![Spotify Dashboard](spotify_pic.png)

---

## 🔍 Sample Visual Insights

- **Top Artists:** Post Malone, Ed Sheeran, Dua Lipa
- **Most Streamed Track:** "Blinding Lights"
- **Highest Engagement:** Tracks with higher danceability and valence often have more streams
- **Platform Dominance:** Spotify leads with ~56% of total plays

---

## 🧪 SQL Snippet Example

```sql
-- Most Streamed Artists
CREATE VIEW most_streamed_artists AS
SELECT 
    artist,
    SUM(stream) AS total_streams
FROM spotify
GROUP BY artist 
ORDER BY total_streams DESC
LIMIT 5;
