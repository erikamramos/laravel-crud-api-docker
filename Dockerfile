# Usar una imagen oficial de PHP con soporte para extensiones necesarias
FROM php:8.2-fpm

# Instalar extensiones necesarias de PHP y utilidades del sistema
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libzip-dev \
    zip \
    unzip

# Instalar extensiones de PHP requeridas por Laravel
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl

# Instalar Composer
COPY --from=composer:2.5 /usr/bin/composer /usr/bin/composer

# Establecer directorio de trabajo
WORKDIR /var/www

# Copiar el archivo composer.lock y composer.json
COPY composer.json composer.lock ./

# Instalar dependencias de PHP
RUN composer install --no-scripts --no-autoloader

# Copiar el código fuente de la aplicación
COPY . .

# Instalar dependencias de la aplicación Laravel
RUN composer install

# Asignar permisos a la carpeta de almacenamiento
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Exponer el puerto 8000 para la aplicación
EXPOSE 8000

# Iniciar Laravel usando php artisan serve
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
