# https://github.com/serverless/examples/blob/master/aws-python-rest-api-with-dynamodb/todos/decimalencoder.py
import decimal
import json


# This is a workaround for: http://bugs.python.org/issue16535
class DecimalEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, decimal.Decimal):
            return int(obj)
        return super(DecimalEncoder, self).default(obj)