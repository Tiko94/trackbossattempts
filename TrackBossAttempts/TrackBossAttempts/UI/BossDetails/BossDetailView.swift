import SwiftUI
import SwiftData

struct BossDetailView: View {

    // MARK: - Input
    @Bindable var boss: BossEntry

    // MARK: - Environment / State
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @State private var showDeleteConfirm = false
    @State private var showingAddSheet = false

    private enum Layout {
        case compact
        case regularPortrait
        case regularLandscape
    }

    private func layout(for size: CGSize) -> Layout {
        guard horizontalSizeClass == .regular else { return .compact }
        return size.width > size.height ? .regularLandscape : .regularPortrait
    }

    private let readableWidth: CGFloat = 640

    // MARK: - Derived

    private var headerTitle: String {
        boss.gameTitle.isEmpty ? boss.name : "\(boss.gameTitle) - \(boss.name)"
    }

    private var attemptsLabel: String {
        boss.status != .defeated ? "Attempts" : "Final Attempt"
    }

    // MARK: - Body

    var body: some View {
        GeometryReader { proxy in
            let current = layout(for: proxy.size)

            ZStack(alignment: .top) {
                Background(image: $boss.imageData)

                switch current {
                case .compact:
                    phoneLayout
                case .regularPortrait:
                    portraitLayout
                case .regularLandscape:
                    landscapeLayout
                }
            }
            .safeAreaInset(edge: .bottom) {
                if current != .regularLandscape {
                    AttemptsStepper(attempts: $boss.attempts)
                        .frame(maxWidth: current == .regularPortrait ? readableWidth : .infinity)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            ToolbarItem(placement: .topBarTrailing) { moreMenu }
        }
        .modifier(AddBossSheetModifier(
            isPresented: $showingAddSheet,
            isFullScreen: horizontalSizeClass == .regular,
            bossEntity: boss,
        ))
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .confirmationDialog("Delete this boss?",
                            isPresented: $showDeleteConfirm,
                            titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                context.delete(boss)
                dismiss()
            }
            Button("Cancel", role: .cancel) { }
        }
    }

    private var phoneLayout: some View {
        ScrollView {
            VStack(spacing: 30) {
                avatarAndTitle

                HStack(spacing: 16) {
                    StatusBanner(status: boss.status)
                    StatTile(label: attemptsLabel, value: "\(boss.attempts)")
                }

                StatusPicker(status: $boss.status)

                NotesSection(notes: $boss.notes)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
        }
        .scrollIndicators(.hidden)
    }

    private var portraitLayout: some View {
        ScrollView {
            VStack(spacing: 36) {
                avatarAndTitle

                HStack(spacing: 20) {
                    StatusBanner(status: boss.status)
                    StatTile(label: attemptsLabel, value: "\(boss.attempts)")
                }

                StatusPicker(status: $boss.status)

                NotesSection(notes: $boss.notes)
            }
            .frame(maxWidth: readableWidth)
            .padding(.horizontal, 32)
            .padding(.top, 16)
            .padding(.bottom, 32)
            .frame(maxWidth: .infinity)
        }
        .scrollIndicators(.hidden)
    }

    private var landscapeLayout: some View {
        HStack(alignment: .top, spacing: 28) {

            // Hero column
            VStack(spacing: 24) {
                Spacer(minLength: 0)
                avatarAndTitle
                StatusBanner(status: boss.status)
                    .frame(height: 48)
                Spacer(minLength: 0)
            }
            .padding(28)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(maxWidth: 380)
            .background(
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(.white.opacity(0.06))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .strokeBorder(.white.opacity(0.08), lineWidth: 1)
            )

            VStack(spacing: 24) {
                StatTile(label: attemptsLabel, value: "\(boss.attempts)")

                StatusPicker(status: $boss.status)

                ScrollView {
                    NotesSection(notes: $boss.notes)
                }
                .scrollIndicators(.hidden)
                .frame(maxHeight: .infinity)

                AttemptsStepper(attempts: $boss.attempts)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 32)
        .padding(.top, 8)
        .padding(.bottom, 24)
    }

    // MARK: - Shared pieces

    private var avatarAndTitle: some View {
        VStack(spacing: 30) {
            Avatar(image: $boss.imageData)
                .padding(.top, 8)

            Text(headerTitle)
                .font(.system(size: horizontalSizeClass == .regular ? 32 : 26,
                              weight: .bold))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    // MARK: - Toolbar pieces

    private var moreMenu: some View {
        Menu {
            Button("Reset Attempts", systemImage: "arrow.counterclockwise") {
                boss.attempts = 0
                boss.status = .notStarted
            }

            Button("Edit Boss", systemImage: "pencil") { showingAddSheet = true }
            Button("Delete", systemImage: "trash", role: .destructive) {
                showDeleteConfirm = true
            }
        } label: {
            Image(systemName: "ellipsis")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.white.opacity(0.9))
                .frame(width: 34, height: 34)
                .background(.white.opacity(0.12), in: Circle())
        }
    }
}
