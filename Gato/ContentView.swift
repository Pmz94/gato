//
//  ContentView.swift
//  Gato
//

import SwiftUI

extension Color {
	static let darkGreen = Color(red: 0.12, green: 0.21, blue: 0.15)
	static let darkGray = Color(red: 0.21, green: 0.33, blue: 0.24)
	static let graywhite = Color(red: 0.86, green: 0.86, blue: 0.86)
}

struct ContentView: View {
	@State private var winnerAlert = ""
	@State private var resettingGame = false
	@State private var player = "X"
	@State private var moves = ["", "", "", "", "", "", "", "", ""]
	private var ranges = [(0..<3), (3..<6), (6..<9)]

	var body: some View {
		VStack {
			Spacer()

			Text("Gato").font(.largeTitle.bold()).foregroundColor(.white)

			Spacer()

			VStack() {
				ForEach(ranges, id: \.self) { range in
					HStack {
						ForEach(range, id: \.self) { i in
							Button {
								playerTapped(i)
							} label: {
								RoundedRectangle(cornerRadius: 10)
								.aspectRatio(1.0, contentMode: .fit)
								.foregroundColor(.darkGray)
								.overlay(Text("\(moves[i])")
								.fontWeight(.bold)
								.font(.system(size: 100))
								.foregroundColor(.white)
								)
							}.disabled(moves[i] != "" || resettingGame)
						}
					}
				}
			}
			.frame(maxWidth: .infinity)
			.padding(10)
			.background(.thinMaterial)
			.clipShape(RoundedRectangle(cornerRadius: 10))

			Spacer()

			if !resettingGame {
				Text("Turno del jugador \(player)")
				.font(.largeTitle.bold())
				.foregroundColor(.white)
				.frame(height: 100)
			} else {
				Text("\(winnerAlert)")
				.font(.largeTitle.bold())
				.foregroundColor(.white)
				.frame(height: 50)

				Button {
					resetGame()
				} label: {
					Text("Jugar otra vez")
					.fontWeight(.bold)
					.font(.system(size: 30))
					.foregroundColor(.white)
					.background(
						RoundedRectangle(cornerRadius: 10).fill(
							LinearGradient(
								gradient: Gradient(colors: [.darkGreen, .graywhite]),
								startPoint: .leading,
								endPoint: .trailing
							)
						)
						.frame(width: 200, height: 50)
						.shadow(radius: 3)
					)
				}
			}

			Spacer()
		}
		.padding()
		.background(
			RadialGradient(
				gradient: Gradient(colors: [
					.darkGreen,
					.darkGray
				]),
				center: .center,
				startRadius: 40,
				endRadius: 80
			)
		)
	}

	func playerTapped(_ number: Int) {
		moves[number] = player
		let check = checkGame()

		if check == true {
			winnerAlert = "\(player) gana"
			player = "-"
			resettingGame = true
		} else if !moves.contains("") {
			winnerAlert = "Empate"
			player = "-"
			resettingGame = true
		} else if player == "X" {
			player = "O"
		} else {
			player = "X"
		}
	}

	func checkGame() -> Bool {
		for index in 0...2 {
			let offset = 3 * index

			if moves[0 + offset] == player && moves[1 + offset] == player && moves[2 + offset] == player {
				return true
			}
		}

		for index in 0...2 {
			let offset = 1 * index

			if moves[0 + offset] == player && moves[3 + offset] == player && moves[6 + offset] == player {
				return true
			}
		}

		for index in 0...1 {
			let offset = 2 * index

			if moves[0 + offset] == player && moves[4] == player && moves[8 - offset] == player {
				return true
			}
		}

		return false
	}

	func resetGame() {
		winnerAlert = ""
		resettingGame = false
		player = "X"
		moves = ["", "", "", "", "", "", "", "", ""]
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
