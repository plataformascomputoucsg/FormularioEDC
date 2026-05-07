package com.miproducto.dao;

import com.miproducto.models.TipoIdentificacion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class TipoIdentificacionDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<TipoIdentificacion> obtenerTiposIdentificacion() {
        String sql = "SELECT COD_TIP_IDENTIF, DESCRIPCION FROM MAT_VW_004";
        
        return jdbcTemplate.query(sql, new RowMapper<TipoIdentificacion>() {
            @Override
            public TipoIdentificacion mapRow(ResultSet rs, int rowNum) throws SQLException {
                TipoIdentificacion tipo = new TipoIdentificacion();
                tipo.setCodigo(rs.getString("COD_TIP_IDENTIF"));
                tipo.setDescripcion(rs.getString("DESCRIPCION"));
                return tipo;
            }
        });
    }
}
