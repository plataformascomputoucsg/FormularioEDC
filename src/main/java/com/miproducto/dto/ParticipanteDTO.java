package com.miproducto.dto;

/**
 * DTO con los datos del participante recuperados de la vista edc_vw_otros_partici.
 */
public class ParticipanteDTO {

    private String nombres;
    private String apellidos;
    private String direccion;
    private String celular;
    private String correo;
    private String estadoCivil;
    private String sexo;
    private String codNacionalidad;

    public ParticipanteDTO() {}

    public String getNombres() { return nombres; }
    public void setNombres(String nombres) { this.nombres = nombres; }

    public String getApellidos() { return apellidos; }
    public void setApellidos(String apellidos) { this.apellidos = apellidos; }

    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }

    public String getCelular() { return celular; }
    public void setCelular(String celular) { this.celular = celular; }

    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }

    public String getEstadoCivil() { return estadoCivil; }
    public void setEstadoCivil(String estadoCivil) { this.estadoCivil = estadoCivil; }

    public String getSexo() { return sexo; }
    public void setSexo(String sexo) { this.sexo = sexo; }

    public String getCodNacionalidad() { return codNacionalidad; }
    public void setCodNacionalidad(String codNacionalidad) { this.codNacionalidad = codNacionalidad; }
}
