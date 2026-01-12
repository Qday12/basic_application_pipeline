import unittest
from app import app

class TestHelloWorld(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()

    def test_root_endpoint(self):
        """Test that the root endpoint returns correct status and content"""
        response = self.app.get("/")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data.decode('utf-8'), "Hello World!")

if __name__ == "__main__":
    unittest.main()
