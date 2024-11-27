from flask import Flask, render_template_string
import pytest
app = Flask(__name__)

def add_numbers(a, b):
    return a + b
@app.route("/")
def hello():
    return "<h1 style='color:blue'>Welcome to the Flask App - by Killian</h1>"


@app.route('/run-tests')
def run_tests():
    # Execute pytest programmatically
    test_results = pytest.main(['--tb=short', '--disable-warnings'])

    if test_results == pytest.ExitCode.OK:
        return render_template_string("<h1>All tests passed! ✅</h1>")
    else:
        return render_template_string("<h1>Some tests failed! ❌</h1>")


if __name__ == "__main__":
    app.run(host='0.0.0.0')