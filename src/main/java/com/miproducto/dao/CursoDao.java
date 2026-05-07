package com.miproducto.dao;

import com.miproducto.models.TipoCurso;
import com.miproducto.models.Curso;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class CursoDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<TipoCurso> obtenerTiposCurso() {
        String sql = "SELECT DISTINCT COD_TIPO_CURSO, DESC_TIPO_EVENTO FROM EDC_VW_CURSOS_FORMULARIO WHERE COD_EMPRESA = 1";
        
        return jdbcTemplate.query(sql, new RowMapper<TipoCurso>() {
            @Override
            public TipoCurso mapRow(ResultSet rs, int rowNum) throws SQLException {
                TipoCurso tipo = new TipoCurso();
                tipo.setCodigo(rs.getString("COD_TIPO_CURSO"));
                tipo.setDescripcion(rs.getString("DESC_TIPO_EVENTO"));
                return tipo;
            }
        });
    }

    public List<Curso> obtenerCursosPorTipo(String codTipoCurso) {
        String sql = "SELECT DISTINCT CODIGO, DESC_EVENTO FROM EDC_VW_CURSOS_FORMULARIO WHERE COD_EMPRESA = 1 AND COD_TIPO_CURSO = ?";
        
        return jdbcTemplate.query(sql, new Object[]{codTipoCurso}, new RowMapper<Curso>() {
            @Override
            public Curso mapRow(ResultSet rs, int rowNum) throws SQLException {
                Curso curso = new Curso();
                curso.setCodigo(rs.getString("CODIGO"));
                curso.setDescripcion(rs.getString("DESC_EVENTO"));
                return curso;
            }
        });
    }
}
