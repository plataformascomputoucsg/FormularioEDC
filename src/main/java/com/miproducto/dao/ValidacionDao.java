package com.miproducto.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ValidacionDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    /**
     * Valida la identificación utilizando la función Oracle FRW_FC_VALIDA_IDENTIF.
     * 
     * @param empresa El ID de la empresa (generalmente 1).
     * @param tipoIdent El ID del tipo de identificación (por ejemplo, 2 para cédula).
     * @param identificacion El número de identificación a validar.
     * @return El mensaje de error devuelto por la función, o null/vacío si es válida.
     */
    public String validarIdentificacion(int empresa, int tipoIdent, String identificacion) {
        String sql = "SELECT FRW_FC_VALIDA_IDENTIF(?, ?, ?) FROM DUAL";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{empresa, tipoIdent, identificacion}, String.class);
        } catch (Exception e) {
            // Manejar excepciones si la función no existe o hay error de conexión
            return "Error al validar: " + e.getMessage();
        }
    }
}
