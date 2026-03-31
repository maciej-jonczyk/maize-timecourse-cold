library(mfuzz)

load("vsd.eset.ave.std.sam_pair_min3pt.RDa")

# -------------------------------------------------
# 1. Funkcja wykonująca pojedynczy krok
# -------------------------------------------------
run_one_c <- function(m_val) {
  # Nazwa pliku PDF (z dwoma miejscami po przecinku, żeby uniknąć np. "1.250")
  filename <- sprintf("c_m%.2f.pdf", m_val)
  
  # Otwórz urządzenie graficzne, a na końcu na pewno je zamknij
  pdf(filename)
  on.exit(dev.off(), add = TRUE)   # gwarancja zamknięcia przy błędzie
  
  # Wywołanie Twojej funkcji cselection
  c_res <- cselection(vsd.eset.ave.std,
                      m      = m_val,
                      crange = seq(8, 20, 1),
                      repeats = 10,
                      visu   = TRUE)
  
  # Zwróć listę z kluczem i wynikiem
  list(key = sprintf("c%.2f", m_val), res = c_res)
}

# -------------------------------------------------
# 2. Przygotowanie wektora parametrów
# -------------------------------------------------
m_vals <- seq(1.15, 1.45, by = 0.05)

# -------------------------------------------------
# 3. Liczba rdzeni
# -------------------------------------------------
n_cores <- detectCores()

# -------------------------------------------------
# 4. Równoległe wywołanie
# -------------------------------------------------
out_list <- mclapply(m_vals, run_one_c, mc.cores = n_cores)

# -------------------------------------------------
# 5. Budowa listy wyników w żądanym formacie
# -------------------------------------------------
c_results <- setNames(
  lapply(out_list, `[[`, "res"),
  sapply(out_list, `[[`, "key")
)

# Teraz np. c_results[["c1.30"]] zawiera wynik dla m = 1.30


# Twoja funkcja – opakowujemy całą logikę w jedną funkcję
run_one_m <- function(m_val) {
  # przygotuj nazwę pliku
  filename <- sprintf("Dmin_m%.2f.pdf", m_val)
  
  # otwórz urządzenie graficzne, wykonaj obliczenia, zamknij je
  pdf(filename)
  on.exit(dev.off(), add = TRUE)   # gwarantuje zamknięcie nawet przy błędzie
  
  # wywołanie Twojej funkcji Dmin (zakładam, że jest już załadowana)
  dmin_res <- Dmin(vsd.eset.ave.std,
                   m      = m_val,
                   crange = seq(7, 20, 1),
                   repeats = 10,
                   visu   = TRUE)
  
  # zwróć listę z wynikiem i kluczem
  list(key = sprintf("m%.2f", m_val),
       res = dmin_res)
}

# wektor wartości m
m_vals <- seq(1.15, 1.45, by = 0.05)
# m_vals <- 1.45

# liczba rdzeni, które chcesz wykorzystać
n_cores <- detectCores()

# uruchomienie równoległe
out_list <- mclapply(m_vals, run_one_m, mc.cores = n_cores)

# przekształcenie do listy wyników w takiej samej formie jak w pętli for
dmin_results <- setNames(
  lapply(out_list, `[[`, "res"),
  sapply(out_list, `[[`, "key")
)

# gotowe! dmin_results[[ "m1.15" ]] zawiera wynik dla m = 1.15 itd.