package br.com.todo.model;

public class Estado {

    private Integer codigo;
    private String titulo;

    public Estado() {
    }

    public Estado(Integer codigo, String titulo) {
        this.codigo = codigo;
        this.titulo = titulo;
    }

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

}
