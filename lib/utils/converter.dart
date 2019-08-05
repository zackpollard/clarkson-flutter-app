class DistanceUnitConverter {
  static toMiles(int kilometers) {
    return kilometers * 0.621371;
  }
  static toKilometers(int miles) {
    return miles * 1.60934;
  }
}

class FuelUnitConversion {
  static toLiters({double gallons, double gallonsUS}) {
    if(gallons != null) {
      return gallons * 4.54609;
    }
    if(gallonsUS != null) {
      return gallonsUS * 3.78541;
    }
  }

  static toGallons({double liters, double gallonsUS}) {
    if(liters != null) {
      return liters * 0.219969;
    }
    if(gallonsUS != null) {
      return gallonsUS * 0.832674;
    }
  }

  static toGallonsUS({double liters, double gallons}) {
    if(liters != null) {
      return liters * 0.264172;
    }
    if(gallons != null) {
      return gallons * 1.20095;
    }
  }
}

class ConsumptionConverter {
  static calculateConsumption(String consumptionUnit, double fuelAmount, String fuelUnit, int tripDistance, String distanceUnit) {
    if(consumptionUnit == "l/100km") {
      double fuelAmountLiters = fuelAmount;
      if(fuelUnit == "gal") {
        fuelAmountLiters = FuelUnitConversion.toLiters(gallons: fuelAmount);
      }
      if(fuelUnit == "gal (US)") {
        fuelAmountLiters = FuelUnitConversion.toLiters(gallonsUS: fuelAmount);
      }

      double tripDistanceKm = tripDistance.toDouble();
      if(distanceUnit == "mi") {
        tripDistanceKm = DistanceUnitConverter.toKilometers(tripDistance);
      }

      return ((fuelAmountLiters / tripDistanceKm) * 100).toStringAsFixed(2);
    }

    if(consumptionUnit == "mpg") {
      double fuelAmountGallons = fuelAmount;
      if(fuelUnit == "l") {
        fuelAmountGallons = FuelUnitConversion.toGallons(liters: fuelAmount);
      }
      if(fuelUnit == "gal (US)") {
        fuelAmountGallons = FuelUnitConversion.toGallons(gallonsUS: fuelAmount);
      }

      double tripDistanceMiles = tripDistance.toDouble();
      if(distanceUnit == "km") {
        tripDistanceMiles = DistanceUnitConverter.toMiles(tripDistance);
      }

      return (tripDistanceMiles / fuelAmountGallons).toStringAsFixed(2);
    }
  }
}