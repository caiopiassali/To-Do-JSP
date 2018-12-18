package br.com.todo.model;

import java.util.Date;

public class Tarefa {

    private Integer codigo;
    private String titulo;
    private String texto;
    private Date dataCriacao;
    private Estado estado;
    private Usuario usuario;
    private Boolean lixeira;

    public Tarefa() {
    }

    public Tarefa(Integer codigo, String titulo, String texto, Date dataCriacao, Estado estado, Usuario usuario, Boolean lixeira) {
        this.codigo = codigo;
        this.titulo = titulo;
        this.texto = texto;
        this.dataCriacao = dataCriacao;
        this.estado = estado;
        this.usuario = usuario;
        this.lixeira = lixeira;
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

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public Date getDataCriacao() {
        return dataCriacao;
    }

    public void setDataCriacao(Date dataCriacao) {
        this.dataCriacao = dataCriacao;
    }

    public Estado getEstado() {
        return estado;
    }

    public void setEstado(Estado estado) {
        this.estado = estado;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Boolean getLixeira() {
        return lixeira;
    }

    public void setLixeira(Boolean lixeira) {
        this.lixeira = lixeira;
    }

}
