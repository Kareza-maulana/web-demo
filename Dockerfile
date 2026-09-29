FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    nginx \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy nginx configuration
COPY nginx.conf /etc/nginx/sites-available/default

# Copy application files
COPY . /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html

# Expose port
EXPOSE 8282

# Start PHP-FPM and nginx
CMD service php8.2-fpm start && nginx -g 'daemon off;'
