package com.miproducto.controllers;

import com.miproducto.dto.RegistroDTO;
import com.miproducto.dto.ParticipanteDTO;
import com.miproducto.dao.TipoIdentificacionDao;
import com.miproducto.dao.NacionalidadDao;
import com.miproducto.dao.ValidacionDao;
import com.miproducto.dao.InscripcionDao;
import com.miproducto.dao.ParticipanteDao;
import com.miproducto.models.TipoIdentificacion;
import com.miproducto.models.Nacionalidad;
import com.miproducto.models.TipoCurso;
import com.miproducto.models.Curso;
import com.miproducto.dao.CursoDao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 * Controlador que gestiona el flujo del formulario de registro.
 */
@Controller
public class FormularioController {

    @Autowired
    private TipoIdentificacionDao tipoIdentificacionDao;

    @Autowired
    private NacionalidadDao nacionalidadDao;

    @Autowired
    private ValidacionDao validacionDao;

    @Autowired
    private CursoDao cursoDao;

    @Autowired
    private InscripcionDao inscripcionDao;

    @Autowired
    private ParticipanteDao participanteDao;

    /**
     * Muestra el formulario de registro vacío.
     *
     * @param model el modelo de Spring MVC
     * @return nombre lógico de la vista del formulario
     */
    /**
     * Redirige la raíz al formulario.
     */
    @GetMapping("/")
    public String redirigirAlFormulario() {
        return "redirect:/formulario";
    }

    @GetMapping("/formulario")
    public String mostrarFormulario(Model model) {
        List<TipoIdentificacion> tipos = tipoIdentificacionDao.obtenerTiposIdentificacion();
        List<Nacionalidad> naciones = nacionalidadDao.obtenerNacionalidades();
        List<TipoCurso> tiposCurso = cursoDao.obtenerTiposCurso();

        System.out.println("Tamano de la lista devuelta por DAO (Tipo Identificacion): " + (tipos == null ? "NULL" : tipos.size()));
        // System.out.println("Tamano de la lista devuelta por DAO (Nacionalidad): " + (naciones == null ? "NULL" : naciones.size()));


        model.addAttribute("registroDTO", new RegistroDTO());
        model.addAttribute("tiposIdentificacion", tipos);
        model.addAttribute("nacionalidades", naciones);
        model.addAttribute("tiposCurso", tiposCurso);
        return "formulario";
    }

    /**
     * Procesa el envío del formulario vía AJAX (multipart/form-data).
     * Llama al procedimiento Oracle EDC_KG_TRANSACCIONAL_001.EDC_PR_INS_003 y devuelve JSON.
     *
     * @return JSON con {exito, mensaje} 
     */
    @PostMapping(value = "/formulario", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public String procesarFormulario(
            @RequestParam("nombres")           String nombres,
            @RequestParam("apellidos")          String apellidos,
            @RequestParam("tipoIdentificacion") int    tipoIdentificacion,
            @RequestParam("numIdentificacion")  String numIdentificacion,
            @RequestParam("nacionalidad")       int    nacionalidad,
            @RequestParam("direccionPersonal")  String direccionPersonal,
            @RequestParam("sexo")               String sexo,
            @RequestParam("estadoCivil")        String estadoCivil,
            @RequestParam("correo")             String correo,
            @RequestParam("celular")            String celular,
            @RequestParam("curso")              int    curso,
            @RequestParam(value = "tipoFacturacion",   required = false, defaultValue = "") String tipoFacturacion,
            @RequestParam(value = "nombreRazonSocial", required = false, defaultValue = "") String nombreRazonSocial,
            @RequestParam(value = "ruc",               required = false, defaultValue = "") String ruc,
            @RequestParam(value = "direccionFacturacion", required = false, defaultValue = "") String direccionFacturacion,
            @RequestParam(value = "telefonoFacturacion",  required = false, defaultValue = "") String telefonoFacturacion,
            @RequestParam(value = "emailFacturacion",     required = false, defaultValue = "") String emailFacturacion,
            @RequestParam(value = "copiaCedula",          required = false) MultipartFile copiaCedula
    ) {
        com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
        Map<String, Object> respuesta = new HashMap<>();

        try {
            byte[] docBytes = null;
            String nombreArchivo = null;

            if (copiaCedula != null && !copiaCedula.isEmpty()) {
                docBytes = copiaCedula.getBytes();
                nombreArchivo = copiaCedula.getOriginalFilename();
            }

            String mensaje = inscripcionDao.insertarOtros(
                    1,
                    nombres,
                    apellidos,
                    tipoIdentificacion,
                    numIdentificacion,
                    nacionalidad,
                    direccionPersonal,
                    sexo,
                    estadoCivil,
                    docBytes,
                    nombreArchivo,
                    correo,
                    celular,
                    tipoFacturacion,
                    nombreRazonSocial,
                    ruc,
                    direccionFacturacion,
                    telefonoFacturacion,
                    emailFacturacion,
                    curso
            );

            // PV_MENSAJE null/vacío o "OK" indica éxito
            boolean exito = mensaje == null || mensaje.trim().isEmpty() || mensaje.trim().equalsIgnoreCase("OK");
            respuesta.put("exito", exito);
            respuesta.put("mensaje", exito ? "Inscripción registrada correctamente" : mensaje);

        } catch (Exception e) {
            respuesta.put("exito", false);
            respuesta.put("mensaje", "Error al registrar la inscripción: " + e.getMessage());
        }

        try {
            return mapper.writeValueAsString(respuesta);
        } catch (Exception e) {
            return "{\"exito\":false,\"mensaje\":\"Error al generar respuesta JSON\"}";
        }
    }

    /**
     * Muestra la vista de éxito después de un registro válido.
     *
     * @return nombre lógico de la vista de éxito
     */
    @GetMapping("/exito")
    public String mostrarExito() {
        return "exito";
    }

    @GetMapping("/pago")
    public String mostrarPago() {
        return "pago";
    }

    @GetMapping("/encuesta")
    public String mostrarEncuesta(Model model) {
        List<TipoCurso> tiposCurso = cursoDao.obtenerTiposCurso();
        model.addAttribute("tiposCurso", tiposCurso);
        return "encuesta";
    }

    @GetMapping(value = "/api/validarIdentificacion", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public String validarIdentificacion(
            @RequestParam("empresa") int empresa,
            @RequestParam("tipoIdent") int tipoIdent,
            @RequestParam("identificacion") String identificacion) {
        
        String mensaje = validacionDao.validarIdentificacion(empresa, tipoIdent, identificacion);
        java.util.Map<String, Object> respuesta = new java.util.HashMap<>();
        // El usuario confirma que si es válido devuelve exactamente 'OK'
        boolean esValido = mensaje != null && mensaje.trim().equalsIgnoreCase("OK");
        respuesta.put("valido", esValido);
        respuesta.put("mensaje", mensaje);
        
        try {
            com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
            return mapper.writeValueAsString(respuesta);
        } catch (Exception e) {
            return "{\"valido\": false, \"mensaje\": \"Error interno al procesar JSON\"}";
        }
    }

    @GetMapping(value = "/api/cursos", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<Curso> obtenerCursos(@RequestParam("tipoCurso") String tipoCurso) {
        return cursoDao.obtenerCursosPorTipo(tipoCurso);
    }

    /**
     * Busca los datos de un participante existente en edc_vw_otros_partici
     * para pre-poblar el formulario.
     */
    @GetMapping(value = "/api/buscarParticipante", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public String buscarParticipante(
            @RequestParam("empresa")       int    empresa,
            @RequestParam("tipoIdent")     int    tipoIdent,
            @RequestParam("identificacion") String identificacion) {

        com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
        Map<String, Object> respuesta = new HashMap<>();

        try {
            ParticipanteDTO p = participanteDao.buscarParticipante(empresa, tipoIdent, identificacion);
            if (p != null) {
                respuesta.put("encontrado",     true);
                respuesta.put("nombres",        p.getNombres());
                respuesta.put("apellidos",      p.getApellidos());
                respuesta.put("direccion",      p.getDireccion());
                respuesta.put("celular",        p.getCelular());
                respuesta.put("correo",         p.getCorreo());
                respuesta.put("estadoCivil",    p.getEstadoCivil());
                respuesta.put("sexo",           p.getSexo());
                respuesta.put("codNacionalidad", p.getCodNacionalidad());
            } else {
                respuesta.put("encontrado", false);
            }
            return mapper.writeValueAsString(respuesta);
        } catch (Exception e) {
            return "{\"encontrado\":false}";
        }
    }
}
