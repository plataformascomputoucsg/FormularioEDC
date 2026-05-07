package com.miproducto.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;


import java.io.ByteArrayInputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Types;

@Repository
public class InscripcionDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    /**
     * Llama al procedimiento Oracle EDC_KG_TRANSACCIONAL_001.EDC_PR_INS_003.
     *
     * @param curso Código del curso (PN_CURSO)
     * @return El mensaje devuelto por el procedimiento (PV_MENSAJE OUT)
     * @throws RuntimeException si ocurre un error al ejecutar el procedimiento
     */
    public String insertarOtros(
            int    empresa,
            String nombres,
            String apellidos,
            int    codTipIdentif,
            String numIdentif,
            int    codNacionalidad,
            String direccion,
            String sexo,
            String estCivil,
            byte[] docCedula,
            String rutaCedula,
            String mail,
            String telefono,
            String facTipo,
            String facRazonS,
            String facRuc,
            String facDireccion,
            String facTelefono,
            String facCorreo,
            int    curso
    ) {
        return jdbcTemplate.execute((Connection con) -> {
            StringBuilder strProc = new StringBuilder()
                .append("{call EDC_KG_TRANSACCIONAL_001.EDC_PR_INS_003(")
                .append(empresa).append(",")                                      // PN_EMPRESA
                .append("'").append(nombres).append("',")                         // PV_NOMBRES
                .append("'").append(apellidos).append("',")                       // PV_APELLIDOS
                .append(codTipIdentif).append(",")                                // PN_COD_TIP_IDENTIF
                .append("'").append(numIdentif).append("',")                      // PV_NUM_IDENTIF
                .append(codNacionalidad).append(",")                              // PN_COD_NACIONALIDAD
                .append("'").append(direccion).append("',")                       // PV_DIRECCION
                .append("'").append(sexo).append("',")                            // PV_SEXO
                .append("'").append(estCivil).append("',")                        // PV_EST_CIVIL
                .append(":PB_DOC_CEDULA").append(",")                             // PB_DOC_CEDULA (BLOB)
                .append("'").append(rutaCedula != null ? rutaCedula : "").append("',") // PV_RUTA_CEDULA
                .append("'").append(mail).append("',")                            // PV_MAIL
                .append("'").append(telefono).append("',")                        // PV_TELEFONO
                .append("'").append(facTipo != null ? facTipo : "").append("',")   // PV_FAC_TIPO
                .append("'").append(facRazonS != null ? facRazonS : "").append("',") // PV_FAC_RAZON_S
                .append("'").append(facRuc != null ? facRuc : "").append("',")    // PV_FAC_RUC
                .append("'").append(facDireccion != null ? facDireccion : "").append("',") // PV_FAC_DIRECCION
                .append("'").append(facTelefono != null ? facTelefono : "").append("',")  // PV_FAC_TELEFONO
                .append("'").append(facCorreo != null ? facCorreo : "").append("',")     // PV_FAC_CORREO
                .append(curso).append(",")                                        // PN_CURSO
                .append(":PV_MENSAJE")                                            // PV_MENSAJE (OUT)
                .append(")}");

            System.out.println("SQL Proc: " + strProc.toString());

            try (CallableStatement cs = con.prepareCall(strProc.toString())) {

                // PB_DOC_CEDULA (BLOB)
                if (docCedula != null && docCedula.length > 0) {
                    ByteArrayInputStream inpStr = new ByteArrayInputStream(docCedula);
                    cs.setBlob(":PB_DOC_CEDULA", inpStr);
                } else {
                    cs.setNull(":PB_DOC_CEDULA", Types.BLOB);
                }

                // PV_MENSAJE (OUT)
                cs.registerOutParameter(":PV_MENSAJE", Types.VARCHAR);

                cs.execute();

                return cs.getString(":PV_MENSAJE");
            }
        });
    }
}
