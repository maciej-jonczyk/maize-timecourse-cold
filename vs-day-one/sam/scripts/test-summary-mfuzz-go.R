load("../rdata-saved/mfuzz_c10_m1.25_samALLsig.RDa")

## Załóżmy, że Twój obiekt nazywa się  res  (to ta lista)
## ----------------------------------------------------
## 1.  Sprawdź, co w nim jest
str(c10_m1.25)

## 2.  Pobierz wektor cluster (nazwany) i macierz membership
cl_vec   <- c10_m1.25$cluster               # wektor długości 11936, nazwy = geny
mem_mat  <- c10_m1.25$membership            # macierz 11936 × 10

## 3.  Upewnij się, że nazwy wierszy obu obiektów są zgodne
identical(names(cl_vec), rownames(mem_mat))
# # jeżeli FALSE, dopasuj:
# if (!identical(names(cl_vec), rownames(mem_mat))) {
#   rownames(mem_mat) <- names(cl_vec)   # wymuszenie takiego samego porządku
# }

## 4.  Stwórz data‑frame z dwoma zestawami kolumn
df <- data.frame(
  cluster = cl_vec,                     # pierwsza kolumna – numer klas
  mem_mat,                              # kolejne 10 kolumn – membership
  check.names = FALSE                   # pozwala na nazwę "1", "2", …
)

## 5.  (Opcjonalnie) nadaj sensowne nazwy kolumnom membership
colnames(df)[2:ncol(df)] <- paste0("membership_", seq_len(ncol(mem_mat)))

## 6.  Zobacz rezultat
head(df)

# wczytaj tylko tę linijkę jako tekst
line_3460 <- readLines("../../../input-data/go/go_opis_gen_opis", n = 3460)[3460]

cat(line_3460, "\n")

# podziel linię na pola przy użyciu tabulatora
fields <- strsplit(line_3460, "\t")[[1]]
length(fields)               # ile pól faktycznie jest?
sapply(fields, nchar)        # długość każdego pola – czy któreś jest puste?


go_desc <- read.delim(
  "../../../input-data/go/go_opis_gen_opis",
  header = FALSE,
  stringsAsFactors = FALSE,
  quote = "",               # wyłącz interpretację cudzysłowów
  comment.char = "",        # nie traktuj żadnych znaków jako komentarzy
  fill = TRUE,              # wypełnij brakujące pola NA zamiast błędu
  strip.white = TRUE        # usuń nadmiarowe spacje wokół pól
)