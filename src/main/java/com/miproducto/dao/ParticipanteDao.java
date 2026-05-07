package com.miproducto.dao;

import com.miproducto.dto.ParticipanteDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;

@Repository
public class ParticipanteDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    /**
     * Busca un participante en la vista edc_vw_otros_partici.
     *
     * @param empresa       Código de empresa (generalmente 1).
     * @param tipoIdent     Código del tipo de identificación (ej. 2 para cédula).
     * @param identificacion Número de identificación.
     * @return ParticipanteDTO con los datos encontrados, o null si no existe.
     */
    public ParticipanteDTO buscarParticipante(int empresa, int tipoIdent, String identificacion) {
        String sql = "SELECT NOMBRE, APELLIDO, DIRECCION, " +
                     "TELEFONO, MAIL, EST_CIVIL, DESC_EST_CIVIL, SEXO, COD_NACIONALIDAD " +
                     "FROM edc_vw_otros_partici " +
                     "WHERE cod_empresa = ? AND COD_TIP_IDENTIF = ? AND NUM_IDENTIFICA = ? " +
                     "AND ROWNUM = 1";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{empresa, tipoIdent, identificacion},
                new RowMapper<ParticipanteDTO>() {
                    @Override
                    public ParticipanteDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
                        ParticipanteDTO dto = new ParticipanteDTO();
                        dto.setNombres(rs.getString("NOMBRE"));
                        dto.setApellidos(rs.getString("APELLIDO"));
                        dto.setDireccion(rs.getString("DIRECCION"));
                        dto.setCelular(rs.getString("TELEFONO"));
                        dto.setCorreo(rs.getString("MAIL"));
                        dto.setEstadoCivil(rs.getString("EST_CIVIL"));
                        dto.setSexo(rs.getString("SEXO"));
                        dto.setCodNacionalidad(rs.getString("COD_NACIONALIDAD"));
                        return dto;
                    }
                });
        } catch (EmptyResultDataAccessException e) {
            return null;
        } catch (Exception e) {
            System.err.println("Error al buscar participante: " + e.getMessage());
            return null;
        }
    }
}
