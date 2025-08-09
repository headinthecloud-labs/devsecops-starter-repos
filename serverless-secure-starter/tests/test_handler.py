from src.app.handler import lambda_handler

def test_handler():
    resp = lambda_handler({"queryStringParameters":{"name":"Sean"}}, None)
    assert resp["statusCode"] == 200