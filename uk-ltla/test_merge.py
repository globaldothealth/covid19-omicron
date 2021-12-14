import unittest
from merge_sgtf_daily_geocodes import main

ltla_daily = "test-data/ltla_daily_cases.csv"
sgtf = "test-data/ltla_sgtf.xlsx"
expected = (
    0,
    "2021-11-29T00:00:00.000000000",
    "Lambeth",
    "London",
    16,
    12,
    28,
    1266,
    -0.11385,
    51.46442032,
)


class TestUKLTLA(unittest.TestCase):
    def test_merge(self):
        result = main(ltla_daily, sgtf, output=None).to_records()[0]
        self.assertEqual(repr(result), repr(expected))


if __name__ == '__main__':
    unittest.main()
