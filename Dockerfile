FROM php:8.2-apache

# Set ServerName
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy application files
COPY . /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html

# Expose port (Railway akan otomatis detect)
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
