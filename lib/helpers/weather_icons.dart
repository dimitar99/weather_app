class WeatherIcons {
  getDayIconByCode(String code) {
    String textToReturn = 'assets/images/';
    switch (code) {
      case "113":
        return '${textToReturn}sol.png';
      case "185":
      case "263":
      case "266":
      case "281":
      case "284":
      case "296":
      case "302":
      case "308":
      case "311":
      case "314":
        return '${textToReturn}nube.png';
      case "116":
        return '${textToReturn}nube1.png';
      case "326":
      case "332":
      case "338":
      case "350":
        return '${textToReturn}nube2.png';
      case "200":
      case "389":
      case "395":
        return '${textToReturn}nube3.png';
      case "248":
      case "260":
        return '${textToReturn}nube4.png';
      case "227":
      case "230":
      case "317":
      case "320":
        return '${textToReturn}nube5.png';
      case "176":
      case "182":
      case "293":
      case "299":
      case "305":
      case "353":
      case "356":
      case "359":
      case "362":
        return '${textToReturn}nube6.png';
      case "179":
      case "323":
      case "329":
      case "335":
      case "365":
      case "368":
      case "371":
      case "374":
      case "377":
        return '${textToReturn}nube7.png';
      case "386":
      case "392":
        return '${textToReturn}nube8.png';
      case "119":
      case "122":
      case "143":
        return '${textToReturn}nube10.png';
      default:
        return '${textToReturn}nube10.png';
    }
  }

  getNightIconByCode(String code) {
    String textToReturn = 'assets/images/';
    switch (code) {
      case "113":
        return '${textToReturn}luna.png';
      case "116":
      case "119":
        return '${textToReturn}luna0.png';
      case "176":
      case "182":
      case "293":
      case "299":
      case "305":
      case "353":
      case "356":
      case "359":
      case "362":
        return '${textToReturn}luna1.png';
      case "179":
      case "323":
      case "329":
      case "335":
      case "365":
      case "368":
      case "371":
      case "374":
      case "377":
        return '${textToReturn}luna2.png';
      case "200":
      case "386":
      case "392":
        return '${textToReturn}luna3.png';
      case "185":
      case "263":
      case "266":
      case "281":
      case "284":
      case "296":
      case "302":
      case "308":
      case "311":
      case "314":
        return '${textToReturn}nube.png';
      case "326":
      case "332":
      case "338":
      case "350":
        return '${textToReturn}nube2.png';
      case "389":
      case "395":
        return '${textToReturn}nube3.png';
      case "248":
      case "260":
        return '${textToReturn}nube4.png';
      case "227":
      case "230":
      case "317":
      case "320":
        return '${textToReturn}nube5.png';
      case "122":
      case "143":
        return '${textToReturn}nube10.png';
      default:
        return '${textToReturn}nube10.png';
    }
  }
}
