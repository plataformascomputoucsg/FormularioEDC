package com.miproducto.dao;

import com.miproducto.models.Nacionalidad;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class NacionalidadDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Nacionalidad> obtenerNacionalidades() {
        String sql = "SELECT COD_NACIONALIDAD, DESCRIPCION FROM MAT_VW_007";
        
        return jdbcTemplate.query(sql, new RowMapper<Nacionalidad>() {
            @Override
            public Nacionalidad mapRow(ResultSet rs, int rowNum) throws SQLException {
                Nacionalidad nac = new Nacionalidad();
                nac.setCodigo(rs.getString("COD_NACIONALIDAD"));
                nac.setDescripcion(rs.getString("DESCRIPCION"));
                return nac;
            }
        });
    }
}
