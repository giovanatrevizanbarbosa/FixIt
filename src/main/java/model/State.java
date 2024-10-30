package model;

public enum State {
    ACRE ("Acre")
   ,ALAGOAS ("Alagoas")
   ,AMAPA ("Amapa")
   ,AMAZONAS ("Amazonas")
   ,BAHIA ("Bahia")
   ,CEARA ("Ceará")
   ,ESPIRITO_SANTO ("Espírito Santo")
   ,GOIAS ("Goiás")
   ,MARANHAO ("Maranhão")
   ,MATO_GROSSO ("Mato Grosso")
   ,MATO_GROSSO_SUL ("Mato Grosso do Sul")
   ,MINAS_GERAIS ("Minas Gerais")
   ,PARA ("Pará")
   ,PARAIBA ("Paraíba")
   ,PARANA ("Paraná")
   ,PERNAMBUCO ("Pernambuco")
   ,PIAUI ("Piauí")
   ,RIO_DE_JANEIRO ("Rio de Janeiro")
   ,RIO_GRANDE_DO_NORTE ("Rio Grande do Norte")
   ,RIO_GRANDE_DO_SUL ("Rio Grande do Sul")
   ,RONDONIA ("Rondônia")
   ,RORAIMA ("Roraima")
   ,SANTA_CATARINA ("Santa Catarina")
   ,SAO_PAULO ("São Paulo")
   ,SERGIPE ("Sergipe")
   ,TOCANTINS ("Tocantins")
   ,DISTRITO_FEDERAL ("Distrito Federal");

    private String description;

    State(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}