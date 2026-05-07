package com.miproducto.dto;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import org.springframework.web.multipart.MultipartFile;

/**
 * DTO (Data Transfer Object) para el formulario de registro.
 * Contiene las validaciones de cada campo usando Bean Validation (JSR-303).
 */
public class RegistroDTO {

    // ==== DATOS DEL PROGRAMA ====
    @NotNull(message = "Debe seleccionar un programa")
    private String requierePrograma;

    @NotNull(message = "El curso es obligatorio")
    private String curso;

    // ==== DATOS PERSONALES ====
    @NotNull(message = "El tipo de identificación es obligatorio")
    private String tipoIdentificacion;

    @NotNull(message = "El número de identificación es obligatorio")
    @Size(min = 1, max = 20, message = "El número de identificación debe tener al menos 1 y máximo 20 caracteres")
    private String numIdentificacion;

    @NotNull(message = "Los apellidos son obligatorios")
    @Pattern(regexp = "^[\\p{L}\\s]+$", message = "Los apellidos solo pueden contener letras")
    private String apellidos;

    @NotNull(message = "Los nombres son obligatorios")
    @Pattern(regexp = "^[\\p{L}\\s]+$", message = "Los nombres solo pueden contener letras")
    private String nombres;

    @NotNull(message = "El celular es obligatorio")
    @Pattern(regexp = "^[0-9]{1,10}$", message = "El celular solo puede contener hasta 10 números")
    private String celular;

    @NotNull(message = "El correo es obligatorio")
    @Pattern(
        regexp = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$",
        message = "Debe ingresar un correo electrónico válido"
    )
    private String correo;

    @NotNull(message = "El estado civil es obligatorio")
    private String estadoCivil;

    @NotNull(message = "El sexo es obligatorio")
    private String sexo;

    @NotNull(message = "La nacionalidad es obligatoria")
    private String nacionalidad;

    @NotNull(message = "El género es obligatorio")
    private String genero;

    @NotNull(message = "La dirección es obligatoria")
    private String direccionPersonal;

    // ==== DATOS PARA LA FACTURACIÓN ====
    private String tipoFacturacion;

    @Pattern(regexp = "^[\\p{L}\\p{N}\\s.,&-]*$", message = "Ingrese un nombre o razon social valido")
    private String nombreRazonSocial;

    @Pattern(regexp = "^([0-9]{13})?$", message = "El RUC debe tener 13 dígitos numéricos")
    private String ruc;

    private String direccionFacturacion;

    @Pattern(regexp = "^([0-9]{1,10})?$", message = "El teléfono solo puede contener hasta 10 números")
    private String telefonoFacturacion;

    @Pattern(
        regexp = "^([A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,})?$",
        message = "Debe ingresar un email de facturación válido"
    )
    private String emailFacturacion;

    // ==== DOCUMENTOS ====
    private MultipartFile copiaCedula;

    // ==================== Constructores ====================

    public RegistroDTO() {
    }

    // ==================== Getters y Setters ====================

    public String getRequierePrograma() {
        return requierePrograma;
    }

    public void setRequierePrograma(String requierePrograma) {
        this.requierePrograma = requierePrograma;
    }

    public String getCurso() {
        return curso;
    }

    public void setCurso(String curso) {
        this.curso = curso;
    }

    public String getTipoIdentificacion() {
        return tipoIdentificacion;
    }

    public void setTipoIdentificacion(String tipoIdentificacion) {
        this.tipoIdentificacion = tipoIdentificacion;
    }

    public String getNumIdentificacion() {
        return numIdentificacion;
    }

    public void setNumIdentificacion(String numIdentificacion) {
        this.numIdentificacion = numIdentificacion;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getCelular() {
        return celular;
    }

    public void setCelular(String celular) {
        this.celular = celular;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getEstadoCivil() {
        return estadoCivil;
    }

    public void setEstadoCivil(String estadoCivil) {
        this.estadoCivil = estadoCivil;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public String getNacionalidad() {
        return nacionalidad;
    }

    public void setNacionalidad(String nacionalidad) {
        this.nacionalidad = nacionalidad;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public String getDireccionPersonal() {
        return direccionPersonal;
    }

    public void setDireccionPersonal(String direccionPersonal) {
        this.direccionPersonal = direccionPersonal;
    }

    public String getTipoFacturacion() {
        return tipoFacturacion;
    }

    public void setTipoFacturacion(String tipoFacturacion) {
        this.tipoFacturacion = tipoFacturacion;
    }

    public String getNombreRazonSocial() {
        return nombreRazonSocial;
    }

    public void setNombreRazonSocial(String nombreRazonSocial) {
        this.nombreRazonSocial = nombreRazonSocial;
    }

    public String getRuc() {
        return ruc;
    }

    public void setRuc(String ruc) {
        this.ruc = ruc;
    }

    public String getDireccionFacturacion() {
        return direccionFacturacion;
    }

    public void setDireccionFacturacion(String direccionFacturacion) {
        this.direccionFacturacion = direccionFacturacion;
    }

    public String getTelefonoFacturacion() {
        return telefonoFacturacion;
    }

    public void setTelefonoFacturacion(String telefonoFacturacion) {
        this.telefonoFacturacion = telefonoFacturacion;
    }

    public String getEmailFacturacion() {
        return emailFacturacion;
    }

    public void setEmailFacturacion(String emailFacturacion) {
        this.emailFacturacion = emailFacturacion;
    }

    public MultipartFile getCopiaCedula() {
        return copiaCedula;
    }

    public void setCopiaCedula(MultipartFile copiaCedula) {
        this.copiaCedula = copiaCedula;
    }

    @Override
    public String toString() {
        return "RegistroDTO{" +
                "requierePrograma='" + requierePrograma + '\'' +
                ", curso='" + curso + '\'' +
                ", tipoIdentificacion='" + tipoIdentificacion + '\'' +
                ", numIdentificacion='" + numIdentificacion + '\'' +
                ", apellidos='" + apellidos + '\'' +
                ", nombres='" + nombres + '\'' +
                ", celular='" + celular + '\'' +
                ", correo='" + correo + '\'' +
                ", estadoCivil='" + estadoCivil + '\'' +
                ", sexo='" + sexo + '\'' +
                ", nacionalidad='" + nacionalidad + '\'' +
                ", genero='" + genero + '\'' +
                ", direccionPersonal='" + direccionPersonal + '\'' +
                ", tipoFacturacion='" + tipoFacturacion + '\'' +
                ", nombreRazonSocial='" + nombreRazonSocial + '\'' +
                ", ruc='" + ruc + '\'' +
                ", direccionFacturacion='" + direccionFacturacion + '\'' +
                ", telefonoFacturacion='" + telefonoFacturacion + '\'' +
                ", emailFacturacion='" + emailFacturacion + '\'' +
                '}';
    }
}
