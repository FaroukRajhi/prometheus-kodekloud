import getpass
import bcrypt

password = getpass.getpass('password: ')
hashed_password = bcrypt.hashpw(password.encode('utf8')), bcrypt.gensalt())

print(hashed_password.decode())