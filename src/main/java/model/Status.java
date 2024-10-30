package model;

public enum Status {
    IN_APPROVAL ("Em aprovação")
   ,APPROVED    ("Aprovado")
   ,ON_GOING    ("Em andamento")
   ,COMPLETED   ("Finalizado");

    private String description;

    Status(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}