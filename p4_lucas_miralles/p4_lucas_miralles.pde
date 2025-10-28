PFont myfont;
String onomatopeia = "brum";
float x=50;
int xx=1;

// --- NUEVAS VARIABLES ---
int numCuadrados = 3; // ahora son 3 en lugar de 5
float[][] pos = new float[numCuadrados][2];
float separacionMinima = 100; // distancia mínima entre figuras

void setup() {
  size(560, 879);
  frameRate(20);
  myfont = createFont("B.S.-Mono-Regular.otf", 10);
  textFont(myfont);
}

void draw() {
  background(255);
  fill(0);
  noStroke();

  float cx = width / 2;
  float cy = height / 2;
  float espaciado = 12; // distancia entre letras
  int filas = 5;
  int columnas = 8;

  float rx= random (-100, -20);
  for (float y=0; y<height; y+=17) {
    if (x==-20) {
      xx=20;
    }
    if (x==width ) {
      xx=-20;
    }
    x=x+xx;

    text ("brum", 20+x+random(-20,30), y );
  }
  
  // float rx= random (-80, -10);
  for (float y=0; y<height; y+=15) {
    if (x==-20) {
      xx=20;
    }
    if (x==width ) {
      xx=-20;
    }
    x=x+xx;

    text ("brum", 6+x+random(-20,30), y );
  }

  for (int i = 0; i < 80; i++) {
    float x = random(width);
    float y = random(height);
    if (i % 2 == 0) {
      int idx = i % onomatopeia.length();
      text(onomatopeia.charAt(idx), x + random(-2, 2), y + random(-2, 2));
    }
  }

  //// --- AÑADIDO: FIGURAS DE TEXTO EN ZIGZAG ---
  generarPosicionesNoSolapadas();
  for (int i = 0; i < numCuadrados; i++) {
    dibujarZigZagTexto(pos[i][0], pos[i][1], 6);
  }
}

//// --- NUEVA FUNCIÓN: ZIGZAG DE TEXTO ---
void dibujarZigZagTexto(float x, float y, int filas) {
  float paso = 12;
  for (int j = 0; j < filas; j++) {
    float offsetX = (j % 2 == 0) ? 0 : paso * 0.6; // alterna desplazamiento horizontal
    for (int i = 0; i < filas; i++) {
      float vibracionX = random(-1, 1);
      float vibracionY = random(-1, 1);
      text("brum", x + i * paso + offsetX + vibracionX, y + j * paso + vibracionY);
    }
  }
}

//// --- GENERAR POSICIONES ALEATORIAS SIN SOLAPES ---
void generarPosicionesNoSolapadas() {
  for (int i = 0; i < numCuadrados; i++) {
    boolean valido = false;
    float xTemp = 0;
    float yTemp = 0;
    while (!valido) {
      valido = true;
      xTemp = random(width - 80);
      yTemp = random(height - 80);
      for (int j = 0; j < i; j++) {
        float d = dist(xTemp, yTemp, pos[j][0], pos[j][1]);
        if (d < separacionMinima) {
          valido = false;
          break;
        }
      }
    }
    pos[i][0] = xTemp;
    pos[i][1] = yTemp;
  }
}
