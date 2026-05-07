package com.miproducto.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

/**
 * Configuración principal de Spring MVC.
 * Reemplaza al archivo dispatcher-servlet.xml tradicional.
 */
@Configuration
@EnableWebMvc
@ComponentScan("com.miproducto")
public class WebConfig extends WebMvcConfigurerAdapter {

    /**
     * Configura el ViewResolver para resolver vistas JSP
     * ubicadas en /WEB-INF/views/ con extensión .jsp.
     */
    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setViewClass(JstlView.class);
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
        return resolver;
    }

    /**
     * Permite servir archivos estáticos (CSS, JS, imágenes)
     * desde la carpeta /resources/ del webapp.
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**")
                .addResourceLocations("/resources/");
    }

    /**
     * Habilita la carga de archivos multipart (enctype="multipart/form-data").
     * Requiere Servlet 3.0+ (GlassFish / Tomcat lo soportan).
     */
    @Bean
    public MultipartResolver multipartResolver() {
        return new StandardServletMultipartResolver();
    }
}
