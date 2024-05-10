from flask import Flask
app =  Flask(__name__)
@app.route('/hello')
def hello():
    return "Hello World!"

@app.route('/epam')
def epam():
    return "Welcome to EPAM!"

app.run(host='0.0.0.0', port=8080, debug=True)
#if __name__=='__main__':   
#   app.run(debug = True)

#app.run(port=8080, debug=True)



