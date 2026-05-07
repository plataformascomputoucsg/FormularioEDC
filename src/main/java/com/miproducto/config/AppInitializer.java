package com.miproducto.config;

import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

/**
 * Inicializador de la aplicación web.
 * Reemplaza al archivo web.xml registrando el DispatcherServlet
 * de forma programática mediante la API Servlet 3.0+.
 */
public class AppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

    /**
     * Clases de configuración para el contexto raíz de la aplicación (root context).
     * Aquí se registrarían configuraciones de servicios, repositorios, seguridad, etc.
     */
    @Override
    protected Class<?>[] getRootConfigClasses() {
        return null;
    }

    /**
     * Clases de configuración para el contexto del DispatcherServlet (servlet context).
     * Aquí se registra la configuración web: controladores, view resolvers, etc.
     */
    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class<?>[]{ WebConfig.class };
    }

    /**
     * Mapeo del DispatcherServlet.
     * Con "/" se mapea como servlet por defecto, atendiendo todas las peticiones.
     */
    @Override
    protected String[] getServletMappings() {
        return new String[]{ "/" };
    }

    /**
     * Habilita el soporte multipart del Servlet 3.0 para carga de archivos.
     * Max 10 MB por archivo, 30 MB total por request.
     */
    @Override
    protected void customizeRegistration(ServletRegistration.Dynamic registration) {
        registration.setMultipartConfig(
            new MultipartConfigElement("", 1 * 1024 * 1024, 5 * 1024 * 1024, 0)
        );
    }
}
