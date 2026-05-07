package com.miproducto.models;

public class TipoIdentificacion {
    private String codigo;
    private String descripcion;

    public TipoIdentificacion() {
    }

    public TipoIdentificacion(String codigo, String descripcion) {
        this.codigo = codigo;
        this.descripcion = descripcion;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
}
