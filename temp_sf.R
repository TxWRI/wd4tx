

df <- download_coastal_geometry(type = "basin")

df.geojson <- geojson::to_geojson(df)

geojson::properties_get(df.geojson, property = "Acres")


df.sf <- geojsonsf::geojson_sf(df.geojson, expand_geometries = TRUE)

library(ggplot2)
ggplot(df.sf) +
  geom_sf(aes())




geojsonlint::geojson_hint(df, inform = TRUE)


df.online <- geojsonio::geojson_read("https://gist.githubusercontent.com/mps9506/70861c06ff3990bed07131d1fc4cae7a/raw/882f29e349a2e213cc248dda30270326393eb194/estuary.geojson",
                                     what = "sp", method = "local")


df.online <- geojsonio::geojson_json(df.online)
df.online <- geojsonio::geojson_sf(df.online)

library(dplyr)
library(sf)
df.online %>%

ggplot(df.online) +
  geom_sf(aes(fill = as.factor(FID))) +
  geom_sf_label(aes(label = FID)) +
  scale_fill_viridis_d()

df.online
