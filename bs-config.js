// Configuración de BrowserSync para desarrollo con Docker en Windows
// Usa polling porque inotify no funciona entre Windows y Linux containers
module.exports = {
    files: [
        {
            match: ['/watch/**/*.jsp', '/watch/**/*.js', '/watch/**/*.css', '/watch/**/*.html'],
            fn: function (event, file) {
                this.reload();
            },
            options: {
                usePolling: true,
                interval: 500
            }
        }
    ],
    port: 3000,
    open: false,
    notify: false,
    ui: {
        port: 3001
    },
    logLevel: "info"
};
