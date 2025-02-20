sudo su
# Update and Install dependences
apt-get update 
apt-get -y install python3-venv python3-pip python3-dev build-essential  \
libssl-dev libffi-dev python3-setuptools nginx

# Create Diretory and acess 
mkdir /todolist
cd /todolist
python3 -m venv venv

# Install environment
. venv/bin/activate
pip install wheel
pip install gunicorn Flask Flask-SQLAlchemy


# Cloning apllication
git clone https://github.com/joaomarceloalencar/devops
chown ubuntu:www-data /todolist/devops/Laboratorios/01_Flask

# Copy file to SystemD and habilit service
cp /todolist/devops/Laboratorios/01_Flask/conf/todolist.service /etc/systemd/system/
systemctl start todolist
systemctl enable todolist 

# Configure Nginx Server
cp /todolist/devops/Laboratorios/01_Flask/conf/todolist /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/todolist /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default
systemctl restart nginx
