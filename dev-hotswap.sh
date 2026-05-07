#!/bin/bash
echo "🔥 Compilando código Java para HotSwap..."

docker exec formulario-edc-dev bash -c "
    cd /app && 
    mvn compile -q -DskipTests &&
    echo '⚡ Clases compiladas en target/classes — HotswapAgent detectará los cambios automáticamente.'
"

echo "✅ Listo. HotswapAgent debería inyectar los cambios en caliente."
