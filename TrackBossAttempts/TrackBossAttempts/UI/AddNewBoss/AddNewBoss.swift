import SwiftUI
import WidgetKit
import SwiftData

struct AddNewBossView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var gameTitle = ""
    @State private var name = ""
    @State private var attempts = "0"
    @State private var notes = ""
    @State private var status: BossStatus = .notStarted
    @State var data: Data?

    var bossEntity: BossEntry?

    private var canSave: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty
        && !gameTitle.trimmingCharacters(in: .whitespaces).isEmpty
    }

    init(bossEntity: BossEntry? = nil) {
        self.bossEntity = bossEntity
        _gameTitle = State(initialValue: bossEntity?.gameTitle ?? "")
        _name = State(initialValue: bossEntity?.name ?? "")
        _attempts = State(initialValue: bossEntity?.attempts.description ?? "0")
        _notes = State(initialValue: bossEntity?.notes ?? "")
        _status = State(initialValue: bossEntity?.status ?? .notStarted)
        _data = State(initialValue: bossEntity?.imageData)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                gradient
                ScrollView {
                    VStack(spacing: 16) {
                        formCard(sectionTitle: "GAME TITLE *",
                                 text: $gameTitle)
                        formCard(sectionTitle: "Boss Name *",
                                 text: $name)
                        formCard(sectionTitle: "INITIAL ATTEMPTS *",
                                 text: $attempts,
                                 keyboardType: .numberPad)

                        statusView()

                        BossPhotoPicker(imageData: $data)
                        notesView
                        saveButton
                            .disabled(!canSave)
                    }
                    .padding(.vertical)
                    .padding(.horizontal)
                }
            }
            .scrollContentBackground(.hidden)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarTitleDisplayMode(.inline)
            .navigationTitle("Add New Boss")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    private var notesView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Notes or strategy (Optional)".uppercased())
                .font(.system(size: 13, weight: .semibold))
                .tracking(0.6)
                .foregroundStyle(.white.opacity(0.45))

            TextField("", text: $notes,
                      axis: .vertical)
                .textFieldStyle(.plain)
                .font(.system(size: 19))
                .foregroundStyle(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .tint(Color(red: 0.35, green: 0.55, blue: 0.95))
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(red: 0.114, green: 0.122, blue: 0.145))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(.white.opacity(0.10), lineWidth: 1)
                )
                .lineLimit(3...6)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(red: 0.173, green: 0.180, blue: 0.200))
        )
    }

    private var saveButton: some View {
        Button(action: {
            save()
            WidgetCenter.shared.reloadTimelines(ofKind: "TotalsWidget")
        }) {
            Text("Save".uppercased())
                .font(.system(size: 13, weight: .semibold))
                .tracking(0.6)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .foregroundStyle(.white)
        }
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(canSave ? Color.blue : Color.gray)
        )
    }

    @ViewBuilder
    private func formCard(sectionTitle: String,
                          text: Binding<String>,
                          keyboardType: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(sectionTitle.uppercased())
                .font(.system(size: 13, weight: .semibold))
                .tracking(0.6)
                .foregroundStyle(.white.opacity(0.45))
            TextFieldView(text: text, keyboardType: keyboardType)
//            TextField("", text: text)
//                .textFieldStyle(.plain)
//                .font(.system(size: 19))
//                .foregroundStyle(.white)
//                .tint(Color(red: 0.35, green: 0.55, blue: 0.95))
//                .padding(.horizontal, 14)
//                .padding(.vertical, 12)
//                .background(
//                    RoundedRectangle(cornerRadius: 10, style: .continuous)
//                        .fill(Color(red: 0.114, green: 0.122, blue: 0.145))
//                )
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10, style: .continuous)
//                        .stroke(.white.opacity(0.10), lineWidth: 1)
//                )
//                .keyboardType(keyboardType)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(red: 0.173, green: 0.180, blue: 0.200))
        )
    }

    @ViewBuilder
    private func statusView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("STATUS")
                .font(.system(size: 13, weight: .semibold))
                .tracking(0.6)
                .foregroundStyle(.white.opacity(0.45))

            Picker("Filter", selection: $status) {
                ForEach(BossStatus.allCases) { tab in
                    Text(tab.rawValue.capitalized).tag(tab)
                }
            }
            .pickerStyle(.segmented)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(red: 0.173, green: 0.180, blue: 0.200))
        )
    }
}

extension AddNewBossView {
    private var gradient: some View {
        LinearGradient(
            colors: [
                Color(red: 0.090, green: 0.118, blue: 0.141),
                Color(red: 0.137, green: 0.149, blue: 0.165)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

extension AddNewBossView {
    private func save() {
        if let bossEntity {
            bossEntity.gameTitle = gameTitle
            bossEntity.name = name
            bossEntity.attempts = Int(attempts) ?? 0
            bossEntity.status = status
            bossEntity.notes = notes
            bossEntity.imageData = data
        } else {
            let entry = BossEntry(
                gameTitle: gameTitle,
                name: name,
                attempts: Int(attempts) ?? 0,
                status: status,
                notes: notes,
                imageData: data
            )
            context.insert(entry)
        }
        dismiss()
    }
}
